package body P_Cell is


   procedure Initialize (Cell: in out T_Cell) is
   begin
      Cell := new T_Cell_Record;
      Gtk_New(Cell.Alignment,0.5,0.5,1.0,1.0);
      Gtk_New(Cell.Button);
      Cell.Alignment.Add(Cell.Button);
      --Gtk_New(Cell.Image); --initialize a null image
      --Cell.Button.Set_Image(Gtk_Image_New);
   end Initialize;

   procedure Finalize (Cell: in out T_Cell) is
   begin
      null;
   end;

   procedure Dig(Cell : T_Cell) is
   begin
      if Cell.State = normal then
         Cell.State := Digged;
         if Cell.Mined then
            Cell.Button.Set_Image(
               Gtk_Image_New_From_File("share/icons/mine-rouge.png"));
         else
            case Cell.Nb_Foreign_Mine is
               when 0 => Cell.Button.Destroy;--Set_Label(Cell.Button,"");
               when 1 => Set_Label(Cell.Button,"1");
               when 2 => Set_Label(Cell.Button,"2");
               when 3 => Set_Label(Cell.Button,"3");
               when 4 => Set_Label(Cell.Button,"4");
               when 5 => Set_Label(Cell.Button,"5");
               when 6 => Set_Label(Cell.Button,"6");
               when 7 => Set_Label(Cell.Button,"7");
               when 8 => Set_Label(Cell.Button,"8");
               when others => null;
            end case;
         end if;
      end if;
   end Dig;

   procedure Flag(Cell: T_Cell) is
   begin
      case Cell.State is
         when Normal =>
            Cell.State := Flagged;
            Cell.Button.Set_Image(
               Gtk_Image_New_From_File("share/icons/drapeau-bleu.png"));
         when Flagged =>
            Cell.State := Normal;
            Cell.Button.Set_Image(Gtk_Image_New);
         when others =>
            null;
      end case;
   end Flag;

end P_Cell;
