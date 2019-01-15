class Casacore < Formula
  desc "Suite of C++ libraries for radio astronomy data processing"
  homepage "https://github.com/casacore/casacore"
  url "https://github.com/casacore/casacore/archive/v2.4.1.tar.gz"
  sha256 "58eccc875053b2c6fe44fe53b6463030ef169597ec29926936f18d27b5087d63"
  head "https://github.com/casacore/casacore.git"

  option "without-cxx11", "Build without C++11 support"

  depends_on "cmake" => :build
  depends_on "cfitsio"
  depends_on "wcslib"
  depends_on "python@2" => :recommended
  depends_on "python" => :optional
  depends_on "fftw"
  depends_on "hdf5"
  depends_on "readline"
  depends_on "casacore-data"
  depends_on "gcc"

  if build.with?("python@2")
    # Boost 1.67 changed the Python library name and cmake 3.11.3 doesn't like it
    # Remove the version pin once cmake catches up
    # See https://gitlab.kitware.com/cmake/cmake/merge_requests/1865
    depends_on "boost-python"
    depends_on "numpy"
  end

  if build.with?("python")
    depends_on "boost-python" => "with-python"
    depends_on "numpy"
  end

  def install
    # To get a build type besides "release" we need to change from superenv to std env first
    build_type = "release"
    mkdir_p "build/#{build_type}"
    cd "build/#{build_type}"
    system "sed", "-i '' 's/Boost REQUIRED COMPONENTS python/Boost REQUIRED COMPONENTS python27/g' ../../python/CMakeLists.txt"
    cmake_args = std_cmake_args
    cmake_args.delete "-DCMAKE_BUILD_TYPE=None"
    cmake_args << "-DCMAKE_BUILD_TYPE=#{build_type}"
    cmake_args << "-DCXX11=False" if build.without? "cxx11"

    if build.with? "python@2"
      cmake_args << "-DBUILD_PYTHON=ON"
      cmake_args << "-DPYTHON2_EXECUTABLE=/usr/local/bin/python2"
      cmake_args << "-DPYTHON2_LIBRARY=/usr/local/Frameworks/Python.framework/Versions/2.7/lib/libpython2.7.dylib"
      # XXX Remove once cmake handles Boost 1.67
    else
      cmake_args << "-DBUILD_PYTHON=OFF"
    end

    if build.with? "python"
      cmake_args << "-DBUILD_PYTHON3=ON"
      cmake_args << "-DPYTHON3_EXECUTABLE=/usr/local/bin/python3"
      cmake_args << "-DPYTHON3_LIBRARY=/usr/local/Frameworks/Python.framework/Versions/3.6/lib/libpython3.6.dylib"
      # XXX Remove once cmake handles Boost 1.67
    end

    cmake_args << "-DUSE_FFTW3=ON" << "-DFFTW3_ROOT_DIR=#{HOMEBREW_PREFIX}"
    cmake_args << "-DUSE_HDF5=ON" << "-DHDF5_ROOT_DIR=#{HOMEBREW_PREFIX}"
    cmake_args << "-DUSE_THREADS=ON" << "-DDATA_DIR=#{HOMEBREW_PREFIX}/share/casacore/data"
    system "cmake", "../..", *cmake_args
    system "make", "install"
  end

  test do
    system bin/"findmeastable", "IGRF"
    system bin/"findmeastable", "DE405"
  end
end
