class Wsclean < Formula
  desc "WSClean is a fast widefield interferometric imager"
  homepage "https://sourceforge.net/projects/wsclean/"
  url "https://github.com/guotsuan/homebrew-mwa-tools/raw/master/files/wsclean.tar.gz"
  version "2.6dev"
  sha256 "eecb2335413a5509b76afcd8514d8ac72e8cfbf080ec63eb31736631cc7b0eaf"

  depends_on "cmake" => :build
  depends_on "casacore"
  depends_on "fftw"
  depends_on "boost"
  depends_on "cfitsio"
  depends_on "gsl"
  

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel
    mkdir_p "build"
    cd "build"
    #system "grep","-r 'sincos' -l . | xargs sed -i '' 's/sincos/__sincos/g'"
    patch do
        url "https://github.com/guotsuan/homebrew-mwa-tools/raw/master/files/wsclean_maosx.patch"
        sha256 ""
    end
    cmake_args=std_cmake_args
    #cmake_args<< "-DM_PIl=0xc.90fdaa22168c235p-2L"
    system "cmake", "..", *cmake_args
    system "make", "install" # if this fails, try separate make/make install steps
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test wsclean`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
