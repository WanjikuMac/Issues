defmodule Menuprocess do
  
  #serverProcess
  @doc"""
  This function initializes our server 
  """
  @spec start_link(any()) :: pid()
  def start_link(initial_state \\ []) do
   pid = spawn(__MODULE__, :menu_state, [initial_state])
   Process.register(pid, :process)
   pid 
  end
  
  @doc """
  This function takes a state from the client server and matches it to the right 
  clause and then executes the requested action
  *parameters*
   -`{:additems, item}` - tuple with request function to add an item to the menu
   -`caller`- sender of the request
   -`item` - current state of the server
  """
  @spec menu_state(tuple(), pid()) :: {atom(), tuple(), list(String.t())}
  def menu_state(state) do
    receive do
      {caller, items} ->
        send caller, state
        menu_state(state)
      {caller, :additems, item} ->
        new_state = [item | state]
        send caller, new_state
        menu_state(new_state)
    _error ->
       IO.puts "Couldn't update the menu"
       menu_item(state)
       end
     end
     
     
     #client process
    @doc """
    This function returns a list of all the current items in the system 
    """
    @spec all_items() :: {:ok, list(String.t())}
    def all_items do 
      send :process, {self(), :items}
        receive do state -> inspect state end
    end
    
    @doc """
    This function takes a string item that is to be added to the system
    """
    @spec add_item(String.t()) :: {:ok, list(String.t())}
    def add_item(item)do
      send :process, {self(), :additems, item}
        receive do response -> inspect response end
    end
  end
      
      
        
