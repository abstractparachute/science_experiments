import java.util.Comparator;

/**
 * Created by Owner on 4/2/2016.
 */
public class CompareByPages implements Comparator<Book> {
    public int compare(Book a, Book b){
        return Integer.compare(a.pages, b.pages);
    }
}