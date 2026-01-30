#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# Film Negative processing plig in

import sys
#import os
# GIMP stuff
import gi

gi.require_version('Gimp', '3.0')
from gi.repository import Gimp
gi.require_version('GimpUi', '3.0')
from gi.repository import GimpUi
from gi.repository import GObject
from gi.repository import Gio

from gi.repository import GLib

# some macros
def N_(message): return message
def _(message): return GLib.dgettext(None, message)


class FilmNegative (Gimp.PlugIn):
    def do_query_procedures(self):
        return ['film-negative']

    def do_set_i18n(self, name):
        return False

    def do_create_procedure(self, name):
        procedure = Gimp.ImageProcedure.new(self, name, Gimp.PDBProcType.PLUGIN, self.run, None)

        procedure.set_image_types('*')
        procedure.set_sensitivity_mask(Gimp.ProcedureSensitivityMask.DRAWABLE)
        procedure.set_menu_label('Film Negative')
        procedure.add_menu_path('<Image>/Colors/')
        procedure.set_documentation(_('Film Negative'), _('Film Negative 3.0'), name)
        procedure.set_attribution('SteveWW', 'SteveWW', '2026')

        # Options
        procedure.add_int_argument('adj-exposure',
                                   'Adjust Exposure',
                                   'Exposure compension applied',
                                   10, 100, 100, GObject.ParamFlags.READWRITE)
        procedure.add_boolean_argument('is-black-white',
                                       'Black and White',
                                       'Desaturate the image',
                                       False, GObject.ParamFlags.READWRITE)
        procedure.add_boolean_argument('is-slide',
                                       'Slide',
                                       'Invert the image',
                                       False, GObject.ParamFlags.READWRITE)

        return procedure

    def run(self, procedure, run_mode, image, drawables, config, run_data):
        
        if len(drawables) != 1:
            msg = _('{} only work with one drawable').format(procedure.get_name())
            error = GLib.Error.new_literal(Gimp.PlugIn.error_quark(), msg, 0)
            return procedure.new_return_values(Gimp.PDBStatusType.CALLING_ERROR, error)
        else:
            drawable = drawables[0]

        if run_mode == Gimp.RunMode.INTERACTIVE:
            GimpUi.init('film-negative')
            dialog = GimpUi.ProcedureDialog(procedure=procedure, config=config)
            # args to be displayed
            dialog.fill(['adj-exposure', 'is-black-white', 'is-slide'])

            is_ok = dialog.run()
            if not is_ok:
                dialog.destroy()
                return procedure.new_return_values(Gimp.PDBStatusType.CANCEL, GLib.Error())

        #Gimp.message('Starting')
        adjExposure = config.get_property('adj-exposure')
        isBlackWhite = config.get_property('is-black-white')
        isSlide = config.get_property('is-slide')

        #Gimp.message('BW {}'.format(isBlackWhite))
        if isBlackWhite:
            ok = drawable.desaturate(Gimp.DesaturateMode.LUMINANCE)
            if not ok:
                msg = _('Desaturate failed')
                error = GLib.Error.new_literal(Gimp.PlugIn.error_quark(), msg, 0)
                return procedure.new_return_values(Gimp.PDBStatusType.GIMP_PDB_EXECUTION_ERROR, error)

        if not isSlide:
            ok = drawable.invert(False)
            if not ok:
                msg = _('Invert failed')
                error = GLib.Error.new_literal(Gimp.PlugIn.error_quark(), msg, 0)
                return procedure.new_return_values(Gimp.PDBStatusType.GIMP_PDB_EXECUTION_ERROR, error)

        # best guess colur tweak
        ok = drawable.levels_stretch()
        if not ok:
            msg = _('Stretch failed')
            error = GLib.Error.new_literal(Gimp.PlugIn.error_quark(), msg, 0)
            return procedure.new_return_values(Gimp.PDBStatusType.GIMP_PDB_EXECUTION_ERROR, error)

        # Exposure Adjustment
        #Gimp.message('Adj {}'.format(adjExposure))
        if adjExposure != 100:
            ok = drawable.levels(Gimp.HistogramChannel.VALUE, 0.0, adjExposure / 100, False, 1.0, 0.0, 1.0, False)
            if not ok:
                msg = _('Exposure failed')
                error = GLib.Error.new_literal(Gimp.PlugIn.error_quark(), msg, 0)
                return procedure.new_return_values(Gimp.PDBStatusType.GIMP_PDB_EXECUTION_ERROR, error)

        return procedure.new_return_values(Gimp.PDBStatusType.SUCCESS, GLib.Error())

Gimp.main(FilmNegative.__gtype__, sys.argv)

