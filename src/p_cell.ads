with Ada.Text_IO; use Ada.Text_IO;
with Ada.Finalization; use Ada.Finalization;
with Ada.Unchecked_Deallocation ;
with Glib; use Glib;
with Gtk.Alignment; use Gtk.Alignment;
with Gtk.Button; use Gtk.Button;
with Gtk.Enums; use Gtk.Enums;
with Gtk.Image; use Gtk.Image;
with Gtk.Label; use Gtk.Label;
with Gtk.Handlers ;

package P_Cell is

   type T_Cell_State is (Normal, Digged, Flagged);

   type T_Cell_Record is new Controlled with record
      Alignment: Gtk_Alignment;
      Button: Gtk_Button;
      Mined: Boolean := false;
      Nb_Foreign_Mine : Natural := 0;
      State: T_Cell_State := Normal;
      Image: Gtk_Image;
      Label: Gtk_Label;
   end record;

   type T_Cell is access all T_Cell_Record;

   procedure free is new Ada.Unchecked_Deallocation(
      T_Cell_Record,T_Cell) ;

   procedure Initialize (Cell: in out T_Cell);

   procedure Finalize (Cell: in out T_Cell);

   procedure Dig( Cell: T_Cell);

   procedure Flag( Cell: T_Cell);


end P_Cell;
