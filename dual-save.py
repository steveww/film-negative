#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# Save image as XCF and JPG simulaneously

import sys
import os
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

class DualSave (Gimp.PlugIn):
    def do_query_procedures(self):
        return ['dual-save']

    def do_set_i18n(self, name):
        return False

    def do_create_procedure(self, name):
        procedure = Gimp.ImageProcedure.new(self, name, Gimp.PDBProcType.PLUGIN, self.run, None)

        procedure.set_image_types('*')
        procedure.set_sensitivity_mask(Gimp.ProcedureSensitivityMask.DRAWABLE)
        procedure.set_menu_label('Dual Save')
        procedure.add_menu_path('<Image>/File/[Save]')
        procedure.set_documentation(_('Dual Save'), _('Dual Save 3.0'), name)
        procedure.set_attribution('SteveWW', 'SteveWW', '2026')

        return procedure

    def run(self, procedure, run_mode, image, drawables, config, run_data):
        if len(drawables) != 1:
            msg = _('{} only work with one drawable').format(procedure.get_name())
            error = GLib.Error.new_literal(Gimp.PlugIn.error_quark(), msg, 0)
            return procedure.new_return_values(Gimp.PDBStatusType.CALLING_ERROR, error)
        else:
            drawable = drawables[0]

        # check for file name
        if not image.get_file():
            msg = _('No file name')
            error = GLib.Error.new_literal(Gimp.PlugIn.error_quark(), msg, 0)
            return procedure.new_return_values(Gimp.PDBStatusType.GIMP_PDB_EXECUTION_ERROR, error)

        filename = image.get_file().get_path()
        path = os.path.splitext(filename)[0]
        xcf_file = Gio.File.new_for_path(path + '.xcf')
        jpg_file = Gio.File.new_for_path(path + '.jpg')

        Gimp.message('Saving XCF')
        pdb = Gimp.get_pdb()
        pdb_proc = pdb.lookup_procedure('gimp-xcf-save')
        pdb_config = pdb_proc.create_config()
        pdb_config.set_property('run-mode', Gimp.RunMode.NONINTERACTIVE)
        pdb_config.set_property('image', image)
        pdb_config.set_property('file', xcf_file)
        ok = pdb_proc.run(pdb_config)
        if ok.index(0) != Gimp.PDBStatusType.SUCCESS:
            msg = _('Export failed')
            error = GLib.Error.new_literal(Gimp.PlugIn.error_quark(), msg, 0)
            return procedure.new_return_values(Gimp.PDBStatusType.GIMP_PDB_EXECUTION_ERROR, error)

        Gimp.message('Exporting JPG')
        pdb_proc = pdb.lookup_procedure('file-jpeg-export')
        pdb_config = pdb_proc.create_config()
        pdb_config.set_property('run-mode', Gimp.RunMode.NONINTERACTIVE)
        pdb_config.set_property('image', image)
        pdb_config.set_property('file', jpg_file)
        pdb_config.set_property('quality', 0.95)
        pdb_config.set_property('include-exif', True)
        pdb_config.set_property('include-color-profile', True)
        ok = pdb_proc.run(pdb_config)
        if ok.index(0) != Gimp.PDBStatusType.SUCCESS:
            msg = _('Export failed')
            error = GLib.Error.new_literal(Gimp.PlugIn.error_quark(), msg, 0)
            return procedure.new_return_values(Gimp.PDBStatusType.GIMP_PDB_EXECUTION_ERROR, error)

        # all done so mark image as clean
        image.clean_all()

        return procedure.new_return_values(Gimp.PDBStatusType.SUCCESS, GLib.Error())

Gimp.main(DualSave.__gtype__, sys.argv)
