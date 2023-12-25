String displayTimeAgo(Duration difference) {
  String timeAgo;

  if (difference.inSeconds < 60) {
    timeAgo = 'just now';
  } else if (difference.inHours < 1) {
    timeAgo =
        '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
  } else if (difference.inHours < 24) {
    timeAgo =
        '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
  } else if (difference.inDays < 31) {
    timeAgo = '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
  } else if (difference.inDays < 365) {
    timeAgo =
        '${(difference.inDays / 30).floor()} month${(difference.inDays / 30).floor() > 1 ? 's' : ''} ago';
  } else {
    timeAgo =
        '${(difference.inDays / 365).floor()} year${(difference.inDays / 365).floor() > 1 ? 's' : ''} ago';
  }

  return timeAgo;
}
