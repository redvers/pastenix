defmodule Mix.Tasks.Install do
  use Mix.Task
  use PasteDB

  def run(_) do
    IO.puts("Stopping running mnesia node...")
    Amnesia.stop |> IO.inspect
    IO.puts("Destroying current schema")
    Amnesia.Schema.destroy |> IO.inspect
    IO.puts("Creating new schema")
    Amnesia.Schema.create |> IO.inspect
    IO.puts("Restarting mnesia")
    Amnesia.start |> IO.inspect
    IO.puts("Writing new schema to disk")
    PasteDB.Paste.create(disk: [node]) |> IO.inspect
    IO.puts("Waiting for disk completion")
    PasteDB.wait |> IO.inspect
    IO.puts("Reading new status..")
    Amnesia.info
  end
end
    
