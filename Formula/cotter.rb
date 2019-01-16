# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://www.rubydoc.info/github/Homebrew/brew/master/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Cotter < Formula
  desc ""
  homepage ""
  url "https://github.com/MWATelescope/cotter/archive/master.zip"
  version "4.2"
  sha256 "510c75b102acae08473f6060f84f4548c29a14b0e57ca19e234c4d3cfe0dcaad"

  depends_on "cmake" => :build
  depends_on "aoflagger"
  depends_on "pal"

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel
      #
    build_type = "release"
    mkdir_p "build"
    cd "build"
    cmake_args = std_cmake_args
    cmake_args.delete "-DCMAKE_BUILD_TYPE=None"
    cmake_args << "-DCMAKE_CXX_FLAGS=-DM_PIl=0xc.90fdaa22168c235p-2L -Dsincos=__sincos"

    inreplace "../CMakeLists.txt", "Boost REQUIRED COMPONENTS date_time filesystem python", "Boost REQUIRED COMPONENTS date_time filesystem python27"
    inreplace "../CMakeLists.txt", "Boost_PYTHON_LIBRARIES", "Boost_PYTHON27_LIBRARIES"

    system "cmake", "..", *cmake_args
    system "make", "install" # if this fails, try separate make/make install steps
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test cotter`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
