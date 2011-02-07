# quinc

Process and distribute files. Hopefully easily.


## Install

    gem install quinc


## Usage

    quinc = Quinc.new("~/Pictures/")

    # Only distribute files modified in the last three days
    quinc.file_processors << Quinc::Processors::FileModTime.new(3.days.ago)

    # Only distribute image files
    quinc.file_processors << Quinc::Processors::FilterByExtension.new("png", "gif", "jpg")

    # Make a thumbnail of each of the image files and distribute those too
    quinc.file_processors << Quinc::Processors::ThumbnailImages(:size => "300x200", :filename_prefix => "thumb-")

    # Destinations wil be copied to in order added to quinc
    quinc.destinations << Quinc::Destinations::FileSystem("/path/to/destination")
    quinc.destinations << Quinc::Destinations::S3("bucket_name", "authorization")
    quinc.destinations << Quinc::Destinations::SFTP("host", "path")


## Extension

Processors can be any class with a #process method. The processor will be given an array of files. That array should be filtered, added to, and returned.

Destinations can be any class with a #send method. The destination will be given an array of files to copy.

## Copyright

Copyright Brad Wilson. See LICENSE for details.

