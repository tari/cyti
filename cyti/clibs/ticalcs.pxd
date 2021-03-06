# CyTI - A Cython module for linking with TI calculators.
#
# Copyright (C) 2013 Alex Hamlin
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation; either version 3 of the
# License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# libticalcs C API declaration

from libc.stdint cimport uint8_t, uint16_t

cimport ticables, tifiles, glib

cdef extern from "ticalcs.h":
    ctypedef struct CalcHandle:
        pass

    ctypedef enum CalcPixelFormat:
        CALC_PIXFMT_MONO = 1
        CALC_PIXFMT_GRAY_4 = 2
        CALC_PIXFMT_RGB_565_LE = 3

    ctypedef enum CalcScreenFormat:
        SCREEN_FULL
        SCREEN_CLIPPED

    ctypedef struct CalcScreenCoord:
        int format
        unsigned int width
        unsigned int height
        unsigned int clipped_width
        unsigned int clipped_height
        CalcPixelFormat pixel_format

    int ticalcs_library_init()
    int ticalcs_library_exit()

    char* ticalcs_version_get()

    CalcHandle* ticalcs_handle_new(tifiles.CalcModel calc_model)
    int ticalcs_handle_del(CalcHandle* calc_handle)

    int ticalcs_cable_attach(CalcHandle* calc_handle, ticables.CableHandle* cable_handle)
    int ticalcs_cable_detach(CalcHandle* calc_handle)

    int ticalcs_calc_isready(CalcHandle* calc_handle)

    int ticalcs_calc_send_key(CalcHandle* calc_handle, uint16_t keycode)

    int ticalcs_calc_recv_idlist(CalcHandle* calc_handle, uint8_t* buf)

    int ticalcs_calc_get_dirlist(CalcHandle* calc_handle, glib.GNode** var_tree, glib.GNode** app_tree)
    void ticalcs_dirlist_destroy(glib.GNode** tree)

    int ticalcs_calc_recv_var(CalcHandle* calc_handle, int calc_mode, tifiles.FileContent* file_content, tifiles.VarEntry* var_entry)
    int ticalcs_calc_send_var(CalcHandle* calc_handle, int calc_mode, tifiles.FileContent* file_content)
    int ticalcs_calc_del_var(CalcHandle* calc_handle, tifiles.VarEntry* var_entry)

    int ticalcs_calc_recv_screen(CalcHandle* calc_handle, CalcScreenCoord* sc, uint8_t** bitmap)

    int ticalcs_probe(ticables.CableModel cable_model, ticables.CablePort cable_port, tifiles.CalcModel* calc_model, int all)
