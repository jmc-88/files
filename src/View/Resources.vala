namespace Resources {
    public const string APP_TITLE = "Marlin";
    public const string COPYRIGHT = "Copyright 2010 Elementary Developers";
    public const string ELEMENTARY_URL = "http://www.elementary-project.com";
    public const string ELEMENTARY_LABEL = "elementary-project.com";
    public const string COMMENTS = "File Manager";
    
    public const string[] AUTHORS = { 
        "ammonkey <am.monkeyd@gmail.com>",
        "Mathijs Henquet <mathijs.henquet@gmail.com>",
        null
    };
    
    public const string[] ARTISTS = { 
        "Daniel Foré <daniel.p.fore@gmail.com>",
        null
    };

    public const string ICON_ABOUT_LOGO = "system-file-manager";

    public const string LICENSE = """
Marlin is free software; you can redistribute it and/or modify it under the 
terms of the GNU Lesser General Public License as published by the Free 
Software Foundation; either version 2 of the License, or (at your option) 
any later version.

Marlin is distributed in the hope that it will be useful, but WITHOUT 
ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for 
more details.

You should have received a copy of the GNU Lesser General Public License 
along with Marlin; if not, write to the Free Software Foundation, Inc., 
51 Franklin St, Fifth Floor, Boston, MA  02110-1301 USA
""";

    /*public const int DEFAULT_ICON_SCALE = 24;

    public Gdk.Pixbuf? get_icon(string name, int scale = DEFAULT_ICON_SCALE) {
        Gdk.Pixbuf? pixbuf = load_icon(name, 0);
        if (pixbuf == null)
            return null;
            
        if (scale <= 0)
            return pixbuf;
        
        Gdk.Pixbuf scaled_pixbuf = scale_pixbuf(pixbuf, scale, Gdk.InterpType.BILINEAR, false);
        
        return scaled_pixbuf;
    }*/
}
