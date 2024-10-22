package Util;

import Bean.BooksExcel;
import Dao.IBookDao;
import Dao.impl.BookDao;
import com.alibaba.excel.context.AnalysisContext;
import com.alibaba.excel.event.AnalysisEventListener;

public class BookExcelListener extends AnalysisEventListener<BooksExcel> {
    private IBookDao bookDao = new BookDao();

    @Override
    public void invoke(BooksExcel booksExcel, AnalysisContext analysisContext) {
        System.out.println("BlogExcelListener.invoke");
        System.out.println(booksExcel);
        bookDao.addExcel(booksExcel);
    }

    @Override
    public void doAfterAllAnalysed(AnalysisContext analysisContext) {
        System.out.println("BlogExcelListener.doAfterAllAnalysed");
    }
}
