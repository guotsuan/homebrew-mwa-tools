class MwaReduce < Formula
  desc "MWA data reduce tools"
  homepage "https://github.com/guotsuan/homebrew-mwa-tools/raw/master/files/mwa-reduce.tar.gz"
  url "https://github.com/guotsuan/homebrew-mwa-tools/raw/master/files/mwa-reduce.tar.gz"
  version "2019.1.17"
  sha256 "07aab999f0f6ae6a078c445c2bef031ba017c35481c7a5054e6ab9dc306d06d7"

  option "without-avx512"

  depends_on "cmake" => :build
  depends_on "casacore"
  depends_on "fftw"
  depends_on "boost"
  depends_on "cfitsio"

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel
    mkdir_p("build")
    cd "build"
    if build.with?("without-avx512")
        inreplace "../CMakelists.txt", "-march=native", "-march=skylake"
    end
    system "cmake", "..", *std_cmake_args
    system "make", "preinstall" # if this fails, try separate make/make install steps
    mkdir_p("#{prefix}/bin")
    system "mv cluster mwa-cluster"
    system "find . -maxdepth 1 -type f -perm 755 -exec cp {} #{prefix}/bin/ \\;" 

  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test mwa-reduce`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
