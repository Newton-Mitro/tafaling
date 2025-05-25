class UrlHelper {
  static List<String> extractUrls(String text) {
    RegExp urlRegex = RegExp(
      r'((http|https):\/\/[^\s]+)',
      caseSensitive: false,
      multiLine: true,
    );

    Iterable<Match> matches = urlRegex.allMatches(text);
    return matches.map((match) => match.group(0)!).toList();
  }

  static bool isYouTubeUrl(String url) {
    // Regular expression to match YouTube URL
    final RegExp youtubeRegExp = RegExp(
      r'^(https?\:\/\/)?(www\.)?(youtube|youtu|youtube-nocookie)\.(com|be)\/.+$',
      caseSensitive: false,
    );
    return youtubeRegExp.hasMatch(url);
  }

  static bool isValidUrl(String url) {
    final uri = Uri.tryParse(url);
    return uri != null &&
        (uri.isScheme('http') || uri.isScheme('https')) &&
        uri.hasAuthority;
  }
}
