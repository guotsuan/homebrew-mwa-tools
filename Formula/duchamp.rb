# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Duchamp < Formula
  desc "The Duchamp source finder"
  homepage "www.atnf.csiro.au/people/Matthew.Whiting/Duchamp"
  url "https://www.atnf.csiro.au/people/Matthew.Whiting/Duchamp/downloads/Duchamp-1.6.2.tar.gz"
  sha256 "80b35a0fd468347caa91ad8058dc05887c73b4d84f9135c3a292ffd08e9e3be5"

  depends_on "wcslib"
  depends_on "cfitsio"
  depends_on "pgplot"
  def install
    # ENV.deparallelize  # if your formula fails when building in parallel
    # Remove unrecognized options if warned by configure
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}",
                          "--with-pgplotlib=#{Formula["pgplot"].opt_lib}",
                          "--with-pgplotinc=#{Formula["pgplot"].opt_include}"
    system "make"
    system "make","install" # if this fails, try separate make/make install steps
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test Duchamp`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
