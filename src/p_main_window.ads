with Ada.Numerics.Float_Random; use Ada.Numerics.Float_Random;
with Ada.Text_io; use Ada.Text_io;
with Ada.Finalization; use Ada.Finalization;
with Ada.Unchecked_Deallocation ;
with Glib; use Glib;
with Gdk.Event; use Gdk.Event;
with Gtk.Box; use Gtk.Box;
with Gtk.Button; use Gtk.Button;
with Gtk.Combo_Box_Text; use Gtk.Combo_Box_Text;
with Gtk.Dialog; use Gtk.Dialog;
with Gtk.Frame; use Gtk.Frame;
with Gtk.Enums; use Gtk.Enums;
with Gtk.Handlers ;
with Gtk.Label; use Gtk.Label;
with Gtk.Menu; use Gtk.Menu;
with Gtk.Menu_Bar; use Gtk.Menu_Bar;
with Gtk.Menu_Item; use Gtk.Menu_Item;
with Gtk.Message_Dialog; use Gtk.Message_Dialog;
with Gtk.Spin_Button; use Gtk.Spin_Button;
with Gtk.Stock; use Gtk.Stock;
with Gtk.Table; use Gtk.Table;
with Gtk.HButton_Box ;   use Gtk.HButton_Box ;
with Gtk.Main; use Gtk.Main;
with Gtk.Widget; use Gtk.Widget;
with Gtk.Window; use Gtk.window;
with P_Cell; use P_Cell;



package P_Main_Window is

   type T_Cell_Tab is array (natural range<>,natural range<>) of T_Cell;
   type T_Cell_Tab_Access is access all T_Cell_Tab;
   procedure free is new Ada.Unchecked_Deallocation(
      T_Cell_Tab,T_Cell_Tab_Access) ;

   type T_Main_Window_Record is new Controlled with record
      --Game Data
      Height: natural;
      Width: natural;
      Nb_Mine: natural;
      Nb_Flag: natural;
      Nb_Unmined_Cell: natural;
      --Gui object
      Win: Gtk_Window;
      Vbox: Gtk_Vbox;
      Hbox: Gtk_Hbox;
      Counter: Gtk_Label;
      Table: Gtk_Table;

      --Cells
      Cells : access T_Cell_Tab;
   end record;

   type T_Main_Window is access all T_Main_Window_Record;

   type T_Cell_Callback_Data is record
      Main_Window: not null access T_Main_Window_Record;
      Row : Natural;
      Col : Natural;
   end record;



   procedure Init(
      Main_Window : not null access T_Main_Window_Record;
      Height: Natural;
      Width : Natural;
      Nb_Mine: Natural);

   function New_T_Main_Window(
      Height: Natural;
      Width : Natural;
      Nb_Mine: Natural) return T_Main_Window;

   procedure Destroy (
      Main_Window: not null access T_Main_Window_Record);

   procedure Finalize(
      Main_Window : in out T_Main_Window_Record);

   procedure Set_Nb_Flag(
      Main_Window: not null access T_Main_Window_Record;
      Nb_Flag : Natural);

   procedure Place_Mine(
      Main_Window: not null access T_Main_Window_Record;
      row: Natural;
      col: Natural);

   procedure Place_Mines(
      Main_Window: not null access T_Main_Window_Record);

   procedure Reset_Cells(
      Main_Window: not null access T_Main_Window_Record);

   procedure New_Grid(
      Main_Window: not null access T_Main_Window_Record;
      Height: Natural;
      Width: Natural);

   procedure Destroy_Grid(
      Main_Window: not null access T_Main_Window_Record);

   procedure Dig_Around(
      Main_Window: not null access T_Main_Window_Record;
      Row : Natural;
      Col : Natural);

   procedure Loose_Reveal(
      Main_Window: not null access T_Main_Window_Record);

   procedure Win_Reveal(
      Main_Window: not null access T_Main_Window_Record);

   procedure End_Game(
      Main_Window: not null access T_Main_Window_Record;
      Win : boolean);

   procedure New_Game(
      Main_Window: not null access T_Main_Window_Record);

   procedure New_Game(
      Main_Window: not null access T_Main_Window_Record;
      Height: Natural;
      Width: Natural;
      Nb_Mine: Natural);

   procedure Set_Cell_Style(
      Main_Window: not null access T_Main_Window_Record;
      Style : T_Style);

   procedure Stop_Program_Callback(
      Emetteur : access Gtk_Window_Record'class;
      Main_Window : T_Main_Window);

   procedure New_Game_Callback(
      Emitter : access Gtk_Menu_Item_Record'class;
      Main_Window : T_Main_Window);

   procedure New_Grid_Callback(
      Emitter : access Gtk_Menu_Item_Record'class;
      Main_Window : T_Main_Window);

   procedure Destroy_Grid_Callback(
      Emitter : access Gtk_Menu_Item_Record'class;
      Main_Window : T_Main_Window);

   procedure Beginner_Game_Callback(
      Emitter : access Gtk_Menu_Item_Record'class;
      Main_Window : T_Main_Window);

   procedure Advanced_Game_Callback(
      Emitter : access Gtk_Menu_Item_Record'class;
      Main_Window : T_Main_Window);

   procedure Expert_Game_Callback(
      Emitter : access Gtk_Menu_Item_Record'class;
      Main_Window : T_Main_Window);

   procedure Custom_Game_Callback(
      Emitter : access Gtk_Menu_Item_Record'class;
      Main_Window : T_Main_Window);

   procedure Style_Callback(
      Emitter : access Gtk_Menu_Item_Record'class;
      Main_Window : T_Main_Window);

   package P_Window_UHandlers is new Gtk.Handlers.User_Callback(
      Gtk_Window_Record,
      T_Main_Window) ;
   --use P_Window_UHandlers ;

   package P_Menu_Item_UHandlers is new Gtk.Handlers.User_Callback(
      Gtk_Menu_Item_Record,
      T_Main_Window);
   --use P_Menu_Item_UHandlers ;

   package P_Button_UHandlers is new Gtk.Handlers.User_Callback(
      Gtk_Button_Record,
      T_Cell) ;
   use P_Button_UHandlers ;

   package P_Button_URHandlers is new Gtk.Handlers.User_Return_Callback(
      Gtk_Button_Record,
      Boolean,
      T_Cell_Callback_Data) ;
   use P_Button_URHandlers ;

   package P_Message_Ok_URHandlers is new Gtk.Handlers.User_Callback(
      Gtk_Button_Record,
      Gtk_Window) ;
   use P_Message_Ok_URHandlers ;

   type Gtk_Dialog_Access is access all Gtk_Dialog;
   package Destroy_Dialog_Handler is new Gtk.Handlers.User_Callback(
         Gtk_Dialog_Record,
         Gtk_Dialog);
   procedure Destroy_Dialog (Win : access Gtk_Dialog_Record'Class;
      Ptr : Gtk_Dialog);

   procedure Message_Ok_Callback(
      Emitter : access Gtk_Button_Record'Class;
      Message_Win : Gtk_Window);

   function Cell_Clicked_Callback(
      Emetteur : access Gtk_Button_Record'class;
      Event : GDK_Event;
      Data: T_Cell_Callback_Data) return Boolean;

   procedure free is new Ada.Unchecked_Deallocation(
      T_Main_Window_Record,T_Main_Window) ;

end P_Main_Window;
