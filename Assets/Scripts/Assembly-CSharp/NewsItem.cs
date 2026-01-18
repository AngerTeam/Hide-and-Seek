using NewsModule;

public class NewsItem
{
	public NewsItemHierarchy hierarchy;

	public NewsEntries entry;

	public int newsId;

	public NewsItem(NewsItemHierarchy hierarchy, NewsEntries entry, int newsId)
	{
		this.hierarchy = hierarchy;
		this.entry = entry;
		this.newsId = newsId;
	}
}
