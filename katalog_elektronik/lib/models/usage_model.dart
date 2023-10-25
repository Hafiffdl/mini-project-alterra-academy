class UsageData {
  int promptToken; 
  int completionToken; 
  int totalTokens; 

  UsageData({
    required this.promptToken,
    required this.completionToken,
    required this.totalTokens,
  });

  factory UsageData.fromJson(Map<String, dynamic> json) => UsageData(
        promptToken: json["prompt_tokens"],
        completionToken: json["completion_tokens"],
        totalTokens: json["total_tokens"],
      );

  Map<String, dynamic> toJson() => {
        "prompt_tokens": promptToken,
        "completion_tokens": completionToken,
        "total_tokens": totalTokens,
      };
}