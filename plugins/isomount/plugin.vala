/***
    Copyright (c) 2020 elementary LLC <https://elementary.io>

    Pantheon Files is free software; you can redistribute it and/or
    modify it under the terms of the GNU General Public License as
    published by the Free Software Foundation; either version 2 of the
    License, or (at your option) any later version.

    Pantheon Files is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
    General Public License for more details.

    You should have received a copy of the GNU General Public License along
    with this program.  If not, see <http://www.gnu.org/licenses/>.

    Author(s):  Daniele Cocca <dcocca@google.com>
 ***/

public class Marlin.Plugins.IsoMount.MenuItem : Gtk.MenuItem {
    private string iso_file;

    public MenuItem (string iso_file) {
        this.label = "Mount ISO";
        this.iso_file = iso_file;
    }

    public override void activate () {
        try {
            // NOTE: requires the gnome-disk-utility package to be installed.
            // TODO: there surely is a better way that doesn't require shelling out,
            // but this is just a quick hack...
            Process.spawn_sync (
                "/",
                {"gnome-disk-image-mounter", this.iso_file},
                {},
                SpawnFlags.SEARCH_PATH,
                null);
        } catch (Error err) {
            // TODO: fatal errors should be displayed in the UI
            warning (err.message);
        }
    }
}

public class Marlin.Plugins.IsoMount.Plugin : Marlin.Plugins.Base {
    public override void context_menu (Gtk.Widget ? widget, List<GOF.File> files) {
        var menu = widget as Gtk.Menu;
        return_if_fail (menu != null);
        return_if_fail (files != null);

        // We won't show the menu item if the file selection contains multiple files.
        // Mounting an ISO is a very targeted action, and it doesn't make sense to expose
        // the option of mounting if the selection contains a heterogeneous selection of
        // MIME types or even just multiple ISO files.
        if (files.length () != 1) return;

        unowned GOF.File file = files.nth_data (0);
        return_if_fail (file != null);
        // TODO: likely the following should also accept other image file formats...
        if (file.get_ftype () != "application/x-cd-image") return;

        // Bail out if no local path exist.
        // We don't want to attempt mounting remote ISOs.
        var path = file.location.get_path ();
        if (path == null) return;

        // TODO: this should also refuse to add the contextual menu item (or make it a
        // no-op) in case the disk image is already mounted.

        add_menu_item (menu, new Gtk.SeparatorMenuItem ());
        add_menu_item (menu, new IsoMount.MenuItem (path));
    }

    private void add_menu_item (Gtk.Menu menu, Gtk.MenuItem menu_item) {
        menu.append (menu_item);
        menu_item.show ();
        plugins.menuitem_references.add (menu_item);
    }
}

public Marlin.Plugins.Base module_init () {
    return new Marlin.Plugins.IsoMount.Plugin ();
}
