use Amnesia

defdatabase PasteDB do
  deftable Paste, [ :id, :title, :public, :ircchannels, :date, :expires, :previous_version, :content], type: :ordered_set do end
end

defmodule Pastenix.Paste do
## Create Paste
  def create(record) do
    uuid = UUID.uuid1
    Amnesia.transaction do
      modified_record = %{record | id: uuid}
      PasteDB.Paste.write(modified_record)
    end
    uuid
  end
  
## View Paste

  def fetch(id) do
    Amnesia.transaction do
      record = PasteDB.Paste.read(id)
    end
  end
    
## Edit Paste

  def edit(record) do
    originalid = record.id
    uuid = UUID.uuid1
    %{record | id: uuid, previous_version: originalid}
    |> create
  end
    
## Change Permissions
## Query Public Pastes

#def is_public?(id) do
#  Amnesia.transaction do

end
