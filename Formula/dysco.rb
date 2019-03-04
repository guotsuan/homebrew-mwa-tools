# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://www.rubydoc.info/github/Homebrew/brew/master/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Dysco < Formula
  desc "A compressing storage manager for Casacore mearement sets"
  homepage ""
  url "https://github.com/aroffringa/dysco/archive/v1.2.zip"
  sha256 "7a817e7d3d4c4747f88e490bfac969bb15abba01078404620e5da0802cee3147"
  depends_on "cmake" => :build
  depends_on "fftw"

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel
    #
    cmake_args = std_cmake_args
    mkdir_p "build"
    cd "build"
    cmake_args << "-DPYTHON2_EXECUTABLE=/usr/local/bin/python2"
    system "cmake", "..", *cmake_args
    system "make", "install" # if this fails, try separate make/make install steps
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test dysco`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
