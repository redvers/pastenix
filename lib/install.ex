defmodule Mix.Tasks.Install do
  use Mix.Task
  use PasteDB

  def run(_) do
    IO.puts("Stopping running Amnesia node...")
    Amnesia.stop
    IO.puts("Destroying current schema")
    Amnesia.Schema.destroy
    IO.puts("Creating new schema")
    Amnesia.Schema.create
    Amnesia.start
    IO.puts("Writing new schema to disk")
    PasteDB.Paste.create(disk: [node])
    IO.puts("Waiting for disk completion")
    PasteDB.wait
    IO.puts("Reading new status..")
    Amnesia.info
  end
end
    
