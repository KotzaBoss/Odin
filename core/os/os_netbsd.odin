package os

foreign import dl "system:dl"
foreign import libc "system:c"

import "base:runtime"
import "core:strings"
import "core:sys/unix"
import "core:c"

Handle :: distinct i32
File_Time :: distinct u64
Errno :: distinct i32

INVALID_HANDLE :: ~Handle(0)

ERROR_NONE:     Errno : 0 		/* No error */
EPERM:          Errno : 1		/* Operation not permitted */
ENOENT:         Errno : 2		/* No such file or directory */
EINTR:          Errno : 4		/* Interrupted system call */
ESRCH:          Errno : 3		/* No such process */
EIO:            Errno : 5		/* Input/output error */
ENXIO:          Errno : 6		/* Device not configured */
E2BIG:          Errno : 7		/* Argument list too long */
ENOEXEC:        Errno : 8		/* Exec format error */
EBADF:          Errno : 9		/* Bad file descriptor */
ECHILD:         Errno : 10		/* No child processes */
EDEADLK:        Errno : 11		/* Resource deadlock avoided. 11 was EAGAIN */
ENOMEM:         Errno : 12		/* Cannot allocate memory */
EACCES:         Errno : 13		/* Permission denied */
EFAULT:         Errno : 14		/* Bad address */
ENOTBLK:        Errno : 15		/* Block device required */
EBUSY:          Errno : 16		/* Device busy */
EEXIST:         Errno : 17		/* File exists */
EXDEV:          Errno : 18		/* Cross-device link */
ENODEV:         Errno : 19		/* Operation not supported by device */
ENOTDIR:        Errno : 20		/* Not a directory */
EISDIR:         Errno : 21		/* Is a directory */
EINVAL:         Errno : 22		/* Invalid argument */
ENFILE:         Errno : 23		/* Too many open files in system */
EMFILE:         Errno : 24		/* Too many open files */
ENOTTY:         Errno : 25		/* Inappropriate ioctl for device */
ETXTBSY:        Errno : 26		/* Text file busy */
EFBIG:          Errno : 27		/* File too large */
ENOSPC:         Errno : 28		/* No space left on device */
ESPIPE:         Errno : 29		/* Illegal seek */
EROFS:          Errno : 30		/* Read-only file system */
EMLINK:         Errno : 31		/* Too many links */
EPIPE:          Errno : 32		/* Broken pipe */

/* math software */
EDOM:           Errno : 33		/* Numerical argument out of domain */
ERANGE:         Errno : 34		/* Result too large or too small */

/* non-blocking and interrupt i/o */
EAGAIN:         Errno : 35		/* Resource temporarily unavailable */
EWOULDBLOCK:    Errno : EAGAIN	/* Operation would block */
EINPROGRESS:    Errno : 36		/* Operation now in progress */
EALREADY:       Errno : 37		/* Operation already in progress */

/* ipc/network software -- argument errors */
ENOTSOCK:       Errno : 38		/* Socket operation on non-socket */
EDESTADDRREQ:   Errno : 39		/* Destination address required */
EMSGSIZE:       Errno : 40		/* Message too long */
EPROTOTYPE:     Errno : 41		/* Protocol wrong type for socket */
ENOPROTOOPT:    Errno : 42		/* Protocol option not available */
EPROTONOSUPPORT:    Errno : 43		/* Protocol not supported */
ESOCKTNOSUPPORT:    Errno : 44		/* Socket type not supported */
EOPNOTSUPP:     Errno : 45		/* Operation not supported */
EPFNOSUPPORT:   Errno : 46		/* Protocol family not supported */
EAFNOSUPPORT:   Errno : 47		/* Address family not supported by protocol family */
EADDRINUSE:     Errno : 48		/* Address already in use */
EADDRNOTAVAIL:  Errno : 49		/* Can't assign requested address */

/* ipc/network software -- operational errors */
ENETDOWN:       Errno : 50		/* Network is down */
ENETUNREACH:    Errno : 51		/* Network is unreachable */
ENETRESET:      Errno : 52		/* Network dropped connection on reset */
ECONNABORTED:   Errno : 53		/* Software caused connection abort */
ECONNRESET:     Errno : 54		/* Connection reset by peer */
ENOBUFS:        Errno : 55		/* No buffer space available */
EISCONN:        Errno : 56		/* Socket is already connected */
ENOTCONN:       Errno : 57		/* Socket is not connected */
ESHUTDOWN:      Errno : 58		/* Can't send after socket shutdown */
ETOOMANYREFS:   Errno : 59		/* Too many references: can't splice */
ETIMEDOUT:      Errno : 60		/* Operation timed out */
ECONNREFUSED:   Errno : 61		/* Connection refused */

ELOOP:          Errno : 62		/* Too many levels of symbolic links */
ENAMETOOLONG:   Errno : 63		/* File name too long */

/* should be rearranged */
EHOSTDOWN:      Errno : 64		/* Host is down */
EHOSTUNREACH:   Errno : 65		/* No route to host */
ENOTEMPTY:      Errno : 66		/* Directory not empty */

/* quotas & mush */
EPROCLIM:       Errno : 67		/* Too many processes */
EUSERS:         Errno : 68		/* Too many users */
EDQUOT:         Errno : 69		/* Disc quota exceeded */

/* Network File System */
ESTALE:         Errno : 70		/* Stale NFS file handle */
EREMOTE:        Errno : 71		/* Too many levels of remote in path */
EBADRPC:        Errno : 72		/* RPC struct is bad */
ERPCMISMATCH:   Errno : 73		/* RPC version wrong */
EPROGUNAVAIL:   Errno : 74		/* RPC prog. not avail */
EPROGMISMATCH:  Errno : 75		/* Program version wrong */
EPROCUNAVAIL:   Errno : 76		/* Bad procedure for program */

ENOLCK:         Errno : 77		/* No locks available */
ENOSYS:         Errno : 78		/* Function not implemented */

EFTYPE:         Errno : 79		/* Inappropriate file type or format */
EAUTH:          Errno : 80		/* Authentication error */
ENEEDAUTH:      Errno : 81		/* Need authenticator */

/* SystemV IPC */
EIDRM:          Errno : 82		/* Identifier removed */
ENOMSG:         Errno : 83		/* No message of desired type */
EOVERFLOW:      Errno : 84		/* Value too large to be stored in data type */

/* Wide/multibyte-character handling, ISO/IEC 9899/AMD1:1995 */
EILSEQ:         Errno : 85		/* Illegal byte sequence */

/* From IEEE Std 1003.1-2001 */
/* Base, Realtime, Threads or Thread Priority Scheduling option errors */
ENOTSUP:        Errno : 86		/* Not supported */

/* Realtime option errors */
ECANCELED:      Errno : 87		/* Operation canceled */

/* Realtime, XSI STREAMS option errors */
EBADMSG:        Errno : 88		/* Bad or Corrupt message */

/* XSI STREAMS option errors  */
ENODATA:        Errno : 89		/* No message available */
ENOSR:          Errno : 90		/* No STREAM resources */
ENOSTR:         Errno : 91		/* Not a STREAM */
ETIME:          Errno : 92		/* STREAM ioctl timeout */

/* File system extended attribute errors */
ENOATTR:        Errno : 93		/* Attribute not found */

/* Realtime, XSI STREAMS option errors */
EMULTIHOP:      Errno : 94		/* Multihop attempted */
ENOLINK:        Errno : 95		/* Link has been severed */
EPROTO:         Errno : 96		/* Protocol error */

/* Robust mutexes */
EOWNERDEAD:     Errno : 97		/* Previous owner died */
ENOTRECOVERABLE:    Errno : 98		/* State not recoverable */

ELAST:          Errno : 98		/* Must equal largest errno */

/* end of errno */

O_RDONLY   :: 0x000000000
O_WRONLY   :: 0x000000001
O_RDWR     :: 0x000000002
O_CREATE   :: 0x000000200
O_EXCL     :: 0x000000800
O_NOCTTY   :: 0x000008000
O_TRUNC    :: 0x000000400
O_NONBLOCK :: 0x000000004
O_APPEND   :: 0x000000008
O_SYNC     :: 0x000000080
O_ASYNC    :: 0x000000040
O_CLOEXEC  :: 0x000400000

RTLD_LAZY         :: 0x001
RTLD_NOW          :: 0x002
RTLD_GLOBAL       :: 0x100
RTLD_LOCAL        :: 0x200
RTLD_TRACE        :: 0x200
RTLD_NODELETE     :: 0x01000
RTLD_NOLOAD       :: 0x02000

MAX_PATH :: 1024
MAXNAMLEN :: 511

args := _alloc_command_line_arguments()

Unix_File_Time :: struct {
	seconds: time_t,
	nanoseconds: c.long,
}

dev_t :: u64
ino_t :: u64
nlink_t :: u64
off_t :: i64
mode_t :: u16
pid_t :: u32
uid_t :: u32
gid_t :: u32
blkcnt_t :: i64
blksize_t :: i32
fflags_t :: u32
time_t :: i64

OS_Stat :: struct {
	device_id: dev_t,
	mode: mode_t,
	_padding0: i16,
	ino: ino_t,
	nlink: nlink_t,
	uid: uid_t,
	gid: gid_t,
	_padding1: i32,
	rdev: dev_t,

	last_access: Unix_File_Time,
	modified: Unix_File_Time,
	status_change: Unix_File_Time,
	birthtime: Unix_File_Time,

	size: off_t,
	blocks: blkcnt_t,
	block_size: blksize_t,

	flags: fflags_t,
	gen: u32,
	lspare: [2]u32,
}

Dirent :: struct {
	ino: ino_t,
	reclen: u16,
	namlen: u16,
	type: u8,
	name: [MAXNAMLEN + 1]byte,
}

Dir :: distinct rawptr // DIR*

// File type
S_IFMT   :: 0o170000 // Type of file mask
S_IFIFO  :: 0o010000 // Named pipe (fifo)
S_IFCHR  :: 0o020000 // Character special
S_IFDIR  :: 0o040000 // Directory
S_IFBLK  :: 0o060000 // Block special
S_IFREG  :: 0o100000 // Regular
S_IFLNK  :: 0o120000 // Symbolic link
S_IFSOCK :: 0o140000 // Socket

// File mode
// Read, write, execute/search by owner
S_IRWXU :: 0o0700 // RWX mask for owner
S_IRUSR :: 0o0400 // R for owner
S_IWUSR :: 0o0200 // W for owner
S_IXUSR :: 0o0100 // X for owner

// Read, write, execute/search by group
S_IRWXG :: 0o0070 // RWX mask for group
S_IRGRP :: 0o0040 // R for group
S_IWGRP :: 0o0020 // W for group
S_IXGRP :: 0o0010 // X for group

// Read, write, execute/search by others
S_IRWXO :: 0o0007 // RWX mask for other
S_IROTH :: 0o0004 // R for other
S_IWOTH :: 0o0002 // W for other
S_IXOTH :: 0o0001 // X for other

S_ISUID :: 0o4000 // Set user id on execution
S_ISGID :: 0o2000 // Set group id on execution
S_ISVTX :: 0o1000 // Directory restrcted delete

S_ISLNK  :: #force_inline proc(m: mode_t) -> bool { return (m & S_IFMT) == S_IFLNK  }
S_ISREG  :: #force_inline proc(m: mode_t) -> bool { return (m & S_IFMT) == S_IFREG  }
S_ISDIR  :: #force_inline proc(m: mode_t) -> bool { return (m & S_IFMT) == S_IFDIR  }
S_ISCHR  :: #force_inline proc(m: mode_t) -> bool { return (m & S_IFMT) == S_IFCHR  }
S_ISBLK  :: #force_inline proc(m: mode_t) -> bool { return (m & S_IFMT) == S_IFBLK  }
S_ISFIFO :: #force_inline proc(m: mode_t) -> bool { return (m & S_IFMT) == S_IFIFO  }
S_ISSOCK :: #force_inline proc(m: mode_t) -> bool { return (m & S_IFMT) == S_IFSOCK }

F_OK :: 0 // Test for file existance
X_OK :: 1 // Test for execute permission
W_OK :: 2 // Test for write permission
R_OK :: 4 // Test for read permission

foreign libc {
	@(link_name="__errno")		__errno_location :: proc() -> ^c.int ---

	@(link_name="open")             _unix_open          :: proc(path: cstring, flags: c.int, mode: c.int) -> Handle ---
	@(link_name="close")            _unix_close         :: proc(fd: Handle) -> c.int ---
	@(link_name="read")             _unix_read          :: proc(fd: Handle, buf: rawptr, size: c.size_t) -> c.ssize_t ---
	@(link_name="write")            _unix_write         :: proc(fd: Handle, buf: rawptr, size: c.size_t) -> c.ssize_t ---
	@(link_name="lseek")            _unix_seek          :: proc(fd: Handle, offset: i64, whence: c.int) -> i64 ---
	@(link_name="getpagesize")      _unix_getpagesize   :: proc() -> c.int ---
	@(link_name="stat")             _unix_stat          :: proc(path: cstring, stat: ^OS_Stat) -> c.int ---
	@(link_name="lstat")            _unix_lstat         :: proc(path: cstring, sb: ^OS_Stat) -> c.int ---
	@(link_name="fstat")            _unix_fstat         :: proc(fd: Handle, stat: ^OS_Stat) -> c.int ---
	@(link_name="readlink")         _unix_readlink      :: proc(path: cstring, buf: ^byte, bufsiz: c.size_t) -> c.ssize_t ---
	@(link_name="access")           _unix_access        :: proc(path: cstring, mask: c.int) -> c.int ---
	@(link_name="getcwd")           _unix_getcwd        :: proc(buf: cstring, len: c.size_t) -> cstring ---
	@(link_name="chdir")            _unix_chdir         :: proc(buf: cstring) -> c.int ---
	@(link_name="rename")           _unix_rename        :: proc(old, new: cstring) -> c.int ---
	@(link_name="unlink")           _unix_unlink        :: proc(path: cstring) -> c.int ---
	@(link_name="rmdir")            _unix_rmdir         :: proc(path: cstring) -> c.int ---
	@(link_name="mkdir")            _unix_mkdir         :: proc(path: cstring, mode: mode_t) -> c.int ---
	
	@(link_name="fdopendir")        _unix_fdopendir     :: proc(fd: Handle) -> Dir ---
	@(link_name="closedir")         _unix_closedir      :: proc(dirp: Dir) -> c.int ---
	@(link_name="rewinddir")        _unix_rewinddir     :: proc(dirp: Dir) ---
	@(link_name="readdir_r")        _unix_readdir_r     :: proc(dirp: Dir, entry: ^Dirent, result: ^^Dirent) -> c.int ---

	@(link_name="malloc")           _unix_malloc        :: proc(size: c.size_t) -> rawptr ---
	@(link_name="calloc")           _unix_calloc        :: proc(num, size: c.size_t) -> rawptr ---
	@(link_name="free")             _unix_free          :: proc(ptr: rawptr) ---
	@(link_name="realloc")          _unix_realloc       :: proc(ptr: rawptr, size: c.size_t) -> rawptr ---
	
	@(link_name="getenv")           _unix_getenv        :: proc(cstring) -> cstring ---
	@(link_name="realpath")         _unix_realpath      :: proc(path: cstring, resolved_path: rawptr) -> rawptr ---
	@(link_name="sysctlbyname")     _sysctlbyname       :: proc(path: cstring, oldp: rawptr, oldlenp: rawptr, newp: rawptr, newlen: int) -> c.int ---

	@(link_name="exit")             _unix_exit          :: proc(status: c.int) -> ! ---
}

foreign dl {
	@(link_name="dlopen")           _unix_dlopen        :: proc(filename: cstring, flags: c.int) -> rawptr ---
	@(link_name="dlsym")            _unix_dlsym         :: proc(handle: rawptr, symbol: cstring) -> rawptr ---
	@(link_name="dlclose")          _unix_dlclose       :: proc(handle: rawptr) -> c.int ---
	@(link_name="dlerror")          _unix_dlerror       :: proc() -> cstring ---
}

// NOTE(phix): Perhaps share the following functions with FreeBSD if they turn out to be the same in the end.

is_path_separator :: proc(r: rune) -> bool {
	return r == '/'
}

get_last_error :: proc "contextless" () -> int {
	return int(__errno_location()^)
}

open :: proc(path: string, flags: int = O_RDONLY, mode: int = 0) -> (Handle, Errno) {
	runtime.DEFAULT_TEMP_ALLOCATOR_TEMP_GUARD()
	cstr := strings.clone_to_cstring(path, context.temp_allocator)
	handle := _unix_open(cstr, c.int(flags), c.int(mode))
	if handle == -1 {
		return INVALID_HANDLE, Errno(get_last_error())
	}
	return handle, ERROR_NONE
}

close :: proc(fd: Handle) -> Errno {
	result := _unix_close(fd)
	if result == -1 {
		return Errno(get_last_error())
	}
	return ERROR_NONE
}

// We set a max of 1GB to keep alignment and to be safe.
@(private)
MAX_RW :: 1 << 30

read :: proc(fd: Handle, data: []byte) -> (int, Errno) {
	to_read    := min(c.size_t(len(data)), MAX_RW)
	bytes_read := _unix_read(fd, &data[0], to_read)
	if bytes_read == -1 {
		return -1, Errno(get_last_error())
	}
	return int(bytes_read), ERROR_NONE
}

write :: proc(fd: Handle, data: []byte) -> (int, Errno) {
	if len(data) == 0 {
		return 0, ERROR_NONE
	}

	to_write      := min(c.size_t(len(data)), MAX_RW)
	bytes_written := _unix_write(fd, &data[0], to_write)
	if bytes_written == -1 {
		return -1, Errno(get_last_error())
	}
	return int(bytes_written), ERROR_NONE
}

seek :: proc(fd: Handle, offset: i64, whence: int) -> (i64, Errno) {
	res := _unix_seek(fd, offset, c.int(whence))
	if res == -1 {
		return -1, Errno(get_last_error())
	}
	return res, ERROR_NONE
}

file_size :: proc(fd: Handle) -> (i64, Errno) {
	s, err := fstat(fd)
	if err != ERROR_NONE {
		return -1, err
	}
	return s.size, ERROR_NONE
}

rename :: proc(old_path, new_path: string) -> Errno {
	runtime.DEFAULT_TEMP_ALLOCATOR_TEMP_GUARD()
	old_path_cstr := strings.clone_to_cstring(old_path, context.temp_allocator)
	new_path_cstr := strings.clone_to_cstring(new_path, context.temp_allocator)
	res := _unix_rename(old_path_cstr, new_path_cstr)
	if res == -1 {
		return Errno(get_last_error())
	}
	return ERROR_NONE
}

remove :: proc(path: string) -> Errno {
	runtime.DEFAULT_TEMP_ALLOCATOR_TEMP_GUARD()
	path_cstr := strings.clone_to_cstring(path, context.temp_allocator)
	res := _unix_unlink(path_cstr)
	if res == -1 {
		return Errno(get_last_error())
	}
	return ERROR_NONE
}

make_directory :: proc(path: string, mode: mode_t = 0o775) -> Errno {
	runtime.DEFAULT_TEMP_ALLOCATOR_TEMP_GUARD()
	path_cstr := strings.clone_to_cstring(path, context.temp_allocator)
	res := _unix_mkdir(path_cstr, mode)
	if res == -1 {
		return Errno(get_last_error())
	}
	return ERROR_NONE
}

remove_directory :: proc(path: string) -> Errno {
	runtime.DEFAULT_TEMP_ALLOCATOR_TEMP_GUARD()
	path_cstr := strings.clone_to_cstring(path, context.temp_allocator)
	res := _unix_rmdir(path_cstr)
	if res == -1 {
		return Errno(get_last_error())
	}
	return ERROR_NONE
}

is_file_handle :: proc(fd: Handle) -> bool {
	s, err := _fstat(fd)
	if err != ERROR_NONE {
		return false
	}
	return S_ISREG(s.mode)
}

is_file_path :: proc(path: string, follow_links: bool = true) -> bool {
	s: OS_Stat
	err: Errno
	if follow_links {
		s, err = _stat(path)
	} else {
		s, err = _lstat(path)
	}
	if err != ERROR_NONE {
		return false
	}
	return S_ISREG(s.mode)
}

is_dir_handle :: proc(fd: Handle) -> bool {
	s, err := _fstat(fd)
	if err != ERROR_NONE {
		return false
	}
	return S_ISDIR(s.mode)
}

is_dir_path :: proc(path: string, follow_links: bool = true) -> bool {
	s: OS_Stat
	err: Errno
	if follow_links {
		s, err = _stat(path)
	} else {
		s, err = _lstat(path)
	}
	if err != ERROR_NONE {
		return false
	}
	return S_ISDIR(s.mode)
}

is_file :: proc {is_file_path, is_file_handle}
is_dir :: proc {is_dir_path, is_dir_handle}

// NOTE(bill): Uses startup to initialize it

stdin: Handle  = 0
stdout: Handle = 1
stderr: Handle = 2

last_write_time :: proc(fd: Handle) -> (File_Time, Errno) {
	s, err := _fstat(fd)
	if err != ERROR_NONE {
		return 0, err
	}
	modified := s.modified.seconds * 1_000_000_000 + s.modified.nanoseconds
	return File_Time(modified), ERROR_NONE
}

last_write_time_by_name :: proc(name: string) -> (File_Time, Errno) {
	s, err := _stat(name)
	if err != ERROR_NONE {
		return 0, err
	}
	modified := s.modified.seconds * 1_000_000_000 + s.modified.nanoseconds
	return File_Time(modified), ERROR_NONE
}

@private
_stat :: proc(path: string) -> (OS_Stat, Errno) {
	runtime.DEFAULT_TEMP_ALLOCATOR_TEMP_GUARD()
	cstr := strings.clone_to_cstring(path, context.temp_allocator)
	s: OS_Stat = ---
	result := _unix_lstat(cstr, &s)
	if result == -1 {
		return s, Errno(get_last_error())
	}
	return s, ERROR_NONE
}

@private
_lstat :: proc(path: string) -> (OS_Stat, Errno) {
	runtime.DEFAULT_TEMP_ALLOCATOR_TEMP_GUARD()
	cstr := strings.clone_to_cstring(path, context.temp_allocator)
	
	// deliberately uninitialized
	s: OS_Stat = ---
	res := _unix_lstat(cstr, &s)
	if res == -1 {
		return s, Errno(get_last_error())
	}
	return s, ERROR_NONE
}

@private
_fstat :: proc(fd: Handle) -> (OS_Stat, Errno) {
	s: OS_Stat = ---
	result := _unix_fstat(fd, &s)
	if result == -1 {
		return s, Errno(get_last_error())
	}
	return s, ERROR_NONE
}

@private
_fdopendir :: proc(fd: Handle) -> (Dir, Errno) {
	dirp := _unix_fdopendir(fd)
	if dirp == cast(Dir)nil {
		return nil, Errno(get_last_error())
	}
	return dirp, ERROR_NONE
}

@private
_closedir :: proc(dirp: Dir) -> Errno {
	rc := _unix_closedir(dirp)
	if rc != 0 {
		return Errno(get_last_error())
	}
	return ERROR_NONE
}

@private
_rewinddir :: proc(dirp: Dir) {
	_unix_rewinddir(dirp)
}

@private
_readdir :: proc(dirp: Dir) -> (entry: Dirent, err: Errno, end_of_stream: bool) {
	result: ^Dirent
	rc := _unix_readdir_r(dirp, &entry, &result)

	if rc != 0 {
		err = Errno(get_last_error())
		return
	}
	err = ERROR_NONE

	if result == nil {
		end_of_stream = true
		return
	}

	return
}

@private
_readlink :: proc(path: string) -> (string, Errno) {
	runtime.DEFAULT_TEMP_ALLOCATOR_TEMP_GUARD(ignore = context.temp_allocator == context.allocator)

	path_cstr := strings.clone_to_cstring(path, context.temp_allocator)

	bufsz : uint = MAX_PATH
	buf := make([]byte, MAX_PATH)
	for {
		rc := _unix_readlink(path_cstr, &(buf[0]), bufsz)
		if rc == -1 {
			delete(buf)
			return "", Errno(get_last_error())
		} else if rc == int(bufsz) {
			bufsz += MAX_PATH
			delete(buf)
			buf = make([]byte, bufsz)
		} else {
			return strings.string_from_ptr(&buf[0], rc), ERROR_NONE
		}	
	}

	return "", Errno{}
}

absolute_path_from_handle :: proc(fd: Handle) -> (string, Errno) {
	return "", Errno(ENOSYS)
}

absolute_path_from_relative :: proc(rel: string) -> (path: string, err: Errno) {
	rel := rel
	if rel == "" {
		rel = "."
	}
	runtime.DEFAULT_TEMP_ALLOCATOR_TEMP_GUARD(ignore = context.temp_allocator == context.allocator)

	rel_cstr := strings.clone_to_cstring(rel, context.temp_allocator)

	path_ptr := _unix_realpath(rel_cstr, nil)
	if path_ptr == nil {
		return "", Errno(get_last_error())
	}
	defer _unix_free(path_ptr)

	path_cstr := transmute(cstring)path_ptr
	path = strings.clone( string(path_cstr) )

	return path, ERROR_NONE
}

access :: proc(path: string, mask: int) -> (bool, Errno) {
	runtime.DEFAULT_TEMP_ALLOCATOR_TEMP_GUARD()

	cstr := strings.clone_to_cstring(path, context.temp_allocator)
	result := _unix_access(cstr, c.int(mask))
	if result == -1 {
		return false, Errno(get_last_error())
	}
	return true, ERROR_NONE
}

lookup_env :: proc(key: string, allocator := context.allocator) -> (value: string, found: bool) {
	runtime.DEFAULT_TEMP_ALLOCATOR_TEMP_GUARD(ignore = context.temp_allocator == allocator)

	path_str := strings.clone_to_cstring(key, context.temp_allocator)
	cstr := _unix_getenv(path_str)
	if cstr == nil {
		return "", false
	}
	return strings.clone(string(cstr), allocator), true
}

get_env :: proc(key: string, allocator := context.allocator) -> (value: string) {
	value, _ = lookup_env(key, allocator)
	return
}

get_current_directory :: proc() -> string {
	// NOTE(tetra): I would use PATH_MAX here, but I was not able to find
	// an authoritative value for it across all systems.
	// The largest value I could find was 4096, so might as well use the page size.
	page_size := get_page_size()
	buf := make([dynamic]u8, page_size)
	#no_bounds_check for {
		cwd := _unix_getcwd(cstring(&buf[0]), c.size_t(len(buf)))
		if cwd != nil {
			return string(cwd)
		}
		if Errno(get_last_error()) != ERANGE {
			delete(buf)
			return ""
		}
		resize(&buf, len(buf)+page_size)
	}
	unreachable()
}

set_current_directory :: proc(path: string) -> (err: Errno) {
	runtime.DEFAULT_TEMP_ALLOCATOR_TEMP_GUARD()
	cstr := strings.clone_to_cstring(path, context.temp_allocator)
	res := _unix_chdir(cstr)
	if res == -1 do return Errno(get_last_error())
	return ERROR_NONE
}

exit :: proc "contextless" (code: int) -> ! {
	runtime._cleanup_runtime_contextless()
	_unix_exit(c.int(code))
}

current_thread_id :: proc "contextless" () -> int {
	return cast(int) unix.pthread_self()
}

dlopen :: proc(filename: string, flags: int) -> rawptr {
	runtime.DEFAULT_TEMP_ALLOCATOR_TEMP_GUARD()
	cstr := strings.clone_to_cstring(filename, context.temp_allocator)
	handle := _unix_dlopen(cstr, c.int(flags))
	return handle
}

dlsym :: proc(handle: rawptr, symbol: string) -> rawptr {
	assert(handle != nil)
	runtime.DEFAULT_TEMP_ALLOCATOR_TEMP_GUARD()
	cstr := strings.clone_to_cstring(symbol, context.temp_allocator)
	proc_handle := _unix_dlsym(handle, cstr)
	return proc_handle
}

dlclose :: proc(handle: rawptr) -> bool {
	assert(handle != nil)
	return _unix_dlclose(handle) == 0
}

dlerror :: proc() -> string {
	return string(_unix_dlerror())
}

get_page_size :: proc() -> int {
	// NOTE(tetra): The page size never changes, so why do anything complicated
	// if we don't have to.
	@static page_size := -1
	if page_size != -1 do return page_size

	page_size = int(_unix_getpagesize())
	return page_size
}

@(private)
_processor_core_count :: proc() -> int {
	count : int = 0
	count_size := size_of(count)
	if _sysctlbyname("hw.logicalcpu", &count, &count_size, nil, 0) == 0 {
		if count > 0 {
			return count
		}
	}

	return 1
}

_alloc_command_line_arguments :: proc() -> []string {
	res := make([]string, len(runtime.args__))
	for arg, i in runtime.args__ {
		res[i] = string(arg)
	}
	return res
}
