# quinc...

is abandoned. 

It was mainly an experiment for a project at work, and we ended up moving in a different direction. May as well leave it here for posterity...

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
    quinc.file_processors << Quinc::Processors::FilterInByExtension.new("png", "gif", "jpg")
    quinc.file_processors << Quinc::Processors::FilterOutByRegex.new(/\.git/, ".DS_Store")

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

Destinations can be any class with a #transfer method. The destination will be a root path, and a list of partial paths to be copied. It is up to the destination class to combine the partial path with any server path (etc) and then copy.

## Copyright

Copyright Brad Wilson. See LICENSE for details.

