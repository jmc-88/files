/*
 * Copyright (C) 2011, Lucas Baudin <xapantu@gmail.com>
 *
 * Marlin is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation; either version 2 of the
 * License, or (at your option) any later version.
 *
 * Marlin is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 *
 */

#include <gio/gio.h>
#include <gtk/gtk.h>
#include <glib.h>
#include "marlincore-tests-gof.h"


static fatal_handler(const gchar* log_domain,
                               GLogLevelFlags log_level,
                               const gchar* message,
                               gpointer user_data)
{
    return FALSE;
}


void marlincore_tests_goffile(void)
{
    GOFFile* file;

    /* The URI is valid, the target exists */
    file = gof_file_get_by_uri("file:///usr/share");
    g_assert(file != NULL);
    g_assert_cmpstr(file->name, ==, "share");
    g_assert_cmpstr(file->display_name, ==, "share");
    g_assert_cmpstr(file->basename, ==, "share");
    g_assert_cmpint(file->is_directory, ==, TRUE);
    g_assert_cmpint(file->is_hidden, ==, FALSE);
    g_assert_cmpstr(file->ftype, ==, "inode/directory");
    g_assert_cmpint(gof_file_is_symlink(file), ==, FALSE);
    /* TODO: formated_type needs a test too, but there are some issues with
     * translations. */
    g_assert_cmpstr(g_file_get_uri(file->location), ==, "file:///usr/share");
    g_assert_cmpstr(gof_file_get_uri(file), ==, "file:///usr/share");

    /* The URI is valid, the target doesn't exist */
    g_test_log_set_fatal_handler(fatal_handler, NULL);
    file = gof_file_get_by_uri("file:///tmp/very/long/path/azerty");
    g_assert(file != NULL);
    g_test_log_set_fatal_handler(NULL, NULL);
    
    system("rm /tmp/marlin_backup~ /tmp/marlin_sym -f && touch /tmp/marlin_backup~");
    /* The URI is valid, the target exists */
    file = gof_file_get_by_uri("file:///tmp/marlin_backup~");
    g_assert(file != NULL);
    g_assert_cmpint(file->is_directory, ==, FALSE);
    g_assert_cmpint(file->is_hidden, ==, TRUE); /* it's a backup, so, it's hidden */
    g_assert_cmpint(file->size, ==, 0); /* the file is empty since we just create it it */

    system("ln -s /tmp/marlin_backup~ /tmp/marlin_sym ");

    /* a symlink */
    file = gof_file_get_by_uri("file:///tmp/marlin_sym");
    g_assert(file != NULL);
    g_assert_cmpstr(gof_file_get_symlink_target(file), ==, "/tmp/marlin_backup~");
    g_assert_cmpint(gof_file_is_symlink(file), ==, TRUE);
    g_assert_cmpint(file->is_directory, ==, FALSE);
    g_assert_cmpint(file->is_hidden, ==, FALSE);
    g_assert_cmpint(file->size, ==, 0); /* the file is empty since we just create it it */
}
