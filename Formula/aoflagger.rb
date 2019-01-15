class Aoflagger < Formula
  desc "The AOFlagger is a flagger framework to deal radio-frequency interference or RFI"
  homepage "https://sourceforge.net/p/aoflagger/wiki/Home/"
  url "https://raw.githubusercontent.com/guotsuan/homebrew-mwa-tools/master/files/aoflagger-2.13.0.tar.gz"
  version "2.13.0"
  sha256 "55d07d68230779834cccb232e6755a53183b0cd5b2959c68b0a64a28a4ec0b30"
  depends_on "boost"
  depends_on "boost-python"
  depends_on "casacore"
  depends_on "cmake" => :build
  depends_on "cfitsio"
  depends_on "fftw"
  depends_on "hdf5"
  depends_on "libpng"
  depends_on "python@2"

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel

    build_type = "release"
    mkdir_p "build"
    cd "build"
    inreplace "../CMakeLists.txt", "Boost REQUIRED COMPONENTS date_time filesystem python", "Boost REQUIRED COMPONENTS date_time filesystem python27"
    inreplace "../src/CMakeLists.txt", "Boost_PYTHON_LIBRARIES", "Boost_PYTHON27_LIBRARIES"

    cmake_args = std_cmake_args
    cmake_args.delete "-DCMAKE_BUILD_TYPE=None"
    cmake_args << "-DCMAKE_BUILD_TYPE=#{build_type}"

    cmake_args << "-DPYTHON_EXECUTABLE=/usr/local/bin/python2"
    cmake_args << "-DPYTHON2_LIBRARY=/usr/local/Frameworks/Python.framework/Versions/2.7/lib/libpython2.7.dylib"

    system "cmake", "..", *std_cmake_args
    system "make", "install" # if this fails, try separate make/make install steps
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test aoflagger`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
