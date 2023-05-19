rm *.ghw
rm */*.ghw
rm *.cf
rm */*.cf
rm *.o
rm */*.o
rm *.
rm */*.
find . -maxdepth 1 -type f  ! -name "*.*"  -delete
find ./execute -maxdepth 1 -type f  ! -name "*.*"  -delete
find ./instruction_decode -maxdepth 1 -type f  ! -name "*.*"  -delete
find ./instruction_fetch -maxdepth 1 -type f  ! -name "*.*"  -delete
find ./memory -maxdepth 1 -type f  ! -name "*.*"  -delete
find ./write_back -maxdepth 1 -type f  ! -name "*.*"  -delete