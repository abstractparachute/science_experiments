import java.util.Comparator;

/**
 * Created by Owner on 4/2/2016.
 */
public class CompareByTitle implements Comparator<Book> {
    public int compare(Book a, Book b){
        return a.title.compareTo(b.title);
    }
}