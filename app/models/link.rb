class Link
# This class corresponds to a table in the database
# We can use it to manipulate the data
	include DataMapper::Resource
	  # this makes the instances of this class Datamapper resources

	has n, :tags, :through => Resource

	property :id, Serial # Serial means that it will be auto-incremented for every record
	property :title, String
	property :url, String
	 # This block describes what resources our model will have
  # it's a good idea to have a unique id field to differentiate between
  # records with the same title and url (if it ever happens)
	

end

