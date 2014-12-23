use Amnesia

defdatabase PasteDB do
  deftable Paste, [ :id, :title, :public, :ircchannels, :date, :expires, :previous_version, :content], type: :ordered_set do end
  @type t :: %Paste{ id: String.t, title: String.t, public: boolean, ircchannels: [atom], date: integer, expires: integer, previous_version: String.t, content: String.t}
end

defmodule Pastenix.Paste do
  require PasteDB.Paste
  require Exquisite
  @moduledoc """
  Pastenix.Paste is the module that provides the Interface to the back-end
  Mnesia database.  The abstraction is provided so:
    0. Paste storage can be seamlessly moved in the future 
    1. Updates to Agents which do things like store last X public posts
        can be updated directly instead of doing continuous arbitrary
        Mnesia queries.
  """

  @doc """
  Takes a record of the type %PasteDB.Paste and returns the assigned UUID which
  is used to reference it in the future.
  """
  def create(record) do
    uuid = UUID.uuid1
    modified_record = %{record | id: uuid} |> IO.inspect
    Amnesia.transaction do
      PasteDB.Paste.write(modified_record)
    end
    uuid
  end
  

  @doc """
  Takes a string which contains the id: which is used to retrieve the specified Paste.
  Returns the Paste in %PasteDB.Paste record format.
  """
  def fetch(id) do
    Amnesia.transaction do
      PasteDB.Paste.read(id)
    end
  end
    
## Edit Paste

  @doc """
  Takes a Paste in record format and creates a new, linked Paste.  Returns the id: of
  the new record.
  """
  def edit(record) do
    originalid = record.id |> IO.inspect
    uuid = UUID.uuid1 |> IO.inspect
    %{record | id: uuid, previous_version: originalid}
    |> create
  end
    
  #deftable Paste, [ :id, :title, :public, :ircchannels, :date, :expires, :previous_version, :content], type: :ordered_set do end
  def fetchPublicMeta(count) do
    PasteDB.Paste.where!(public == true, select: {date, id, title})
    |> Amnesia.Selection.values
    |> Enum.sort(fn {a,_,_}, {b,_,_} -> a >= b end)
    |> Enum.take(count)
    |> Enum.map(fn {a,b,c} -> %{date: a, id: b, title: c} end)
  end
## Change Permissions
## Query Public Pastes

#def is_public?(id) do
#  Amnesia.transaction do

end
