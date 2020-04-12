require 'shrine'
require 'shrine/storage/file_system'

Shrine.storages = {
  cache: Shrine::Storage::FileSystem.new('public', prefix: 'uploads/cache'), # temporary
  store: Shrine::Storage::FileSystem.new('public', prefix: 'uploads/store') # permanent
}

Shrine.plugin :activerecord           # loads Active Record integration
Shrine.plugin :cached_attachment_data # enables retaining cached file across form redisplays
Shrine.plugin :restore_cached_data
Shrine.plugin :determine_mime_type # check MIME TYPE
Shrine.plugin :validation_helpers, default_messages: {
  mime_type_inclusion: lambda { |_whitelist| # you may use whitelist variable to display allowed types
    "isn't of allowed type. It must be an image."
  }
}

Shrine::Attacher.validate do
  validate_mime_type_inclusion [ # whitelist only these MIME types
    'image/jpeg',
    'image/png',
    'image/gif'
  ]
  validate_max_size 5.megabyte # limit file size to 5MB
end
