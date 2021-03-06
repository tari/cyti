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

# GLib GNode API declaration

cdef extern from "glib.h":
    ctypedef unsigned int guint
    ctypedef void* gpointer
    ctypedef _GNode GNode

    cdef struct _GNode:
        gpointer data

    void g_free(gpointer pointer)
    guint g_node_n_children(GNode* node)
    GNode* g_node_nth_child(GNode* node, guint n)
