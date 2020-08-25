library ieee;
use ieee.std_logic_1164.all;

entity stack is 
port (  clk : in std_logic;
         input : in std_logic_vector ( 7 downto 0 ) ;
          output : out std_logic_vector ( 7 downto 0);
			 pop: in std_logic;
			 push : in std_logic; 
			 empty  : out std_logic;
			 full: out std_logic;
			 en : in std_logic    --enable signal      
			 );
			 
			 end stack;
			 
			 
--------------------------------------------------------------------
--------------------------------------------------------------------

architecture stack of stack is 
type  cells is array ( 15 downto  0) of std_logic_vector ( 7 downto 0);

signal pointer : integer  := 15 ;
signal full_st : std_logic := '0';
signal empty_st : std_logic := '0' ;
signal cell_st :  cells  := ( others => ( others => '0' )) ;

begin 
empty <= empty_st;
full <= full_st; 

process ( clk ,en ,push , pop )
begin 
if ( rising_edge(clk) ) then 


if ( en = '1' and   full_st= '0' and  push  = '1'  and pop = '0' )  then
   cell_st( pointer) <= input ;
	pointer <= pointer -1 ;
	full_st <= '0';
	empty_st<='0';
	       if ( pointer < 0 ) then
           	pointer <= pointer +1 ;
	         full_st <= '1' ;
         	empty_st <= '0' ;
	
       	elsif ( pointer =15 ) then
	         full_st <= '0' ;
         	empty_st <= '1';
	 
	           end if;
	 
	 end if;   --end push
	 
	 if (en = '1'  and empty_st = '0'  and pop = '1' and push = '0' )  then 
	               if ( pointer /= 15 ) then 
	              output <= cell_st ( pointer +1 );
	              pointer <= pointer +1;
					  elsif ( pointer = 15 ) then
					  full_st <= '0';
					  empty_st <= '1';
					  else
					  full_st <= '0' ;
					  empty_st <='0';
					  
	             end if;
	end if;
	
	end if;
	
	end process;
	end stack;
	
	
 