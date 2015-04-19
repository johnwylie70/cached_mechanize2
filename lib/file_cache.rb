require "digest/sha1"
require "zlib"

class CachedMechanize

    class FileCache

      class GzFile
        def self.open(path, &block)
          Zlib::GzipWriter.open(path) do |gz|
            yield gz
          end
        end

        def self.read(path)
          data = nil

          File.open(path) do |file|
            gz = Zlib::GzipReader.new(file)
            data = gz.read
            gz.close
          end

          return data
        end
      end

      ##
      #
      # Options:
      #  - +path+ the path where the cached files should be stored
      #
      def initialize(options={})
        @path = options[:path] || '/tmp'
      end

      def present?(uri, expires_after)
        File.exist?(file_name(uri)) && file_age(uri) <= expires_after
      end

      def retrieve(uri)
        GzFile.read(file_name(uri))
      end

      def store(uri, data)
        GzFile.open(file_name(uri)) do |file|
          file.write(data)
        end
      end

      private

      def file_age(uri)
        Time.now - File.mtime(file_name(uri))
      end

      def file_name(uri)
        File.join(@path, uri_to_key(uri))
      end

      def uri_to_key(uri)
        Digest::SHA1.hexdigest(uri)
      end
    end

end
