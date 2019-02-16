class Nicaea < Formula
  desc "NumerIcal Cosmology And lEnsing cAlculations" 
  homepage "ihttp://cosmostat.org/nicaea"
  url "https://github.com/CosmoStat/nicaea/archive/master.zip"
  version "2.7.2"
  sha256 "5f5271a7d493fcd219687fdab9c2ca2b3a7e6ae5f692635b3c0bced646ef5655"
  depends_on "cmake" => :build
  depends_on "boost"
  depends_on "fftw"
  depends_on "gsl"

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel
    mkdir_p "build"
    cd "build"
    system "cmake", "..", *std_cmake_args
    system "make", "install" # if this fails, try separate make/make install steps
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test nicaea`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
