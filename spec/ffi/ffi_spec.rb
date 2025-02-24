#
# This file is part of ruby-ffi.
# For licensing, see LICENSE.SPECS
#

require File.expand_path(File.join(File.dirname(__FILE__), "spec_helper"))

describe "FFI" do

  describe ".map_library_name" do

    let(:prefix) { FFI::Platform::LIBPREFIX }
    let(:suffix) { FFI::Platform::LIBSUFFIX }

    it "should add platform library extension if not present" do
      expect(FFI.map_library_name("#{prefix}dummy")).to eq("#{prefix}dummy.#{suffix}")
    end

    it "should add platform library extension even if lib suffix is present in name" do
      expect(FFI.map_library_name("#{prefix}dummy_with_#{suffix}")).to eq("#{prefix}dummy_with_#{suffix}.#{suffix}")
    end

    it "should return Platform::LIBC when called with 'c'" do
      expect(FFI.map_library_name('c')).to eq(FFI::Library::LIBC)
    end

    it "should return library path with abi version" do
      expect(FFI.map_library_name(FFI::LibraryPath.new('vips', 42))).to be =~ /#{prefix}vips.*42/
    end

    it "should return library path with root" do
      root = "/non/existant/root"

      expect(FFI.map_library_name(FFI::LibraryPath.new('vips', 42, root))).to be =~ /#{root}/#{prefix}vips.*42/
    end
  end

  describe "VERSION" do
    it "should be kind of version" do
      expect( FFI::VERSION ).to match(/^\d+\.\d+.\d+/)
    end
  end
end
