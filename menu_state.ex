defmodule Menuprocess do
 
  
  #serverProcess
  def start_link(initial_state \\ []) do
  pid = spawn(__MODULE__, :menu_state, [initial_state])
  Process.register(pid, :process)
  pid 
  end
  
  def menu_state(state) do
    receive do
      {sender, items} ->
        send sender, state
        menu_state(state)
      {sender, :additems, item} ->
        new_state = [item | state]
        send sender, value new_state
        menu_state(new_state)
    _error ->
       IO.puts "Couldn't update the menu"
       menu_item(state)
       end
     end
     
     
     #client process
     
     def request do 
      send :process, {self(), :items}
        receive do state -> inspect state end
    end
    
    def add_item(item)do
      send :process, {self(), :additems, item}
        receive do response -> inspect response end
    end
  end
      
      
        
