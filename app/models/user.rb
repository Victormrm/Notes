class User < ApplicationRecord
	has_many:notes
	has_many:collections
	
end
