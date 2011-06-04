# quinc

Process and distribute files. Hopefully easily.


## Install

    gem install quinc


## Usage

    # By default the Sources::Basic file source is used
    quinc = Quinc::Quinc.new("~/Pictures")

    # Only distribute files modified in the last three days
    quinc.file_processors << Quinc::Processors::FileModTime.new(3.days.ago)

    # Only distribute image files
    quinc.file_processors << Quinc::Processors::FilterByExtension.new("png", "gif", "jpg")

    # Make a thumbnail of each of the image files and distribute those too
    quinc.file_processors << Quinc::Processors::ThumbnailImages.new(:size => "300x200", :filename_prefix => "thumb-")

    # Destinations wil be copied to in order added to quinc
    quinc.destinations << Quinc::Destinations::FileSystem.new("/path/to/destination")
    quinc.destinations << Quinc::Destinations::S3.new("bucket_name", "authorization")
    quinc.destinations << Quinc::Destinations::SFTP.new("host", "path")

    quinc.sync

## Extension

Sources can be any class with a #files method. The source can then be set on a quinc object to use that source instead of the default.

Processors can be any class with a #process method. The processor will be given an array of files. That array should be filtered, added to, and returned.

Destinations can be any class with a #send method. The destination will be a root path, and an array of partial paths which can be combined with the root path to get the local file. These local files should be copied.

## Copyright

Copyright Brad Wilson. See LICENSE for details.

