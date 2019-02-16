class Halomodel < Formula
  desc " Library to run halomodel routines"
  homepage "https://github.com/jcoupon/halomodel"
  url "https://github.com/jcoupon/halomodel/archive/master.zip"
  version "1.0.2"
  sha256 "7c8ee033e935ae1b50ae28ad1fdb3bdc32e01db9c02770566dbcca6cd78efe88"
  # depends_on "cmake" => :build
  depends_on "python@2" =>:build
  depends_on "fftw"
  depends_on "gsl"
  depends_on "nicaea"


  def lib_prefix; "/usr/local"; end
  def pythonlib;  "/usr/local/Frameworks/Python.framework/Versions/2.7/lib"; end

  def install
    cd 'halomodel'
    ENV.deparallelize  # if your formula fails when building in parallel
    # Remove unrecognized options if warned by configure

    inreplace "Makefile", "CFLAGS += $(shell python-config --cflags)", "CFLAGS += -I/usr/local/Frameworks/Python.framework/Versions/2.7/include/python2.7" 
    system "make", "PREFIX_NICAEA=#{lib_prefix}"
    system "make", "PREFIX_NICAEA=#{lib_prefix}", "xray"
    
    cd ".."

    bin.install Dir["halomodel/bash/*"]
    bin.install Dir["halomodel/bin/*"]
    lib.install Dir['halomodel/lib/*']
    include.install Dir['halomodel/include/*']

    cp_r Dir['halomodel/*.py'], "#{prefix}/"
    ohai 'Add "/opt/local/opt/halmode" to $PYTHONAPTH'
    ohai 'Depending on Numpy, Scipy, Astropy'

  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test halomodel`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
