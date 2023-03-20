commit;

-- ÃÑ °¹¼ö
select count(*) from book_table where cate_id='language';
select count(*) from book_table where subCate_id='english';
select count(*) from book_table where subCate_id='japanese';
select count(*) from book_table where subCate_id='chinese';


-- ex) Ä«Å×°í¸® + °Ë»ö + ÆäÀÌÂ¡ Ã³¸®
select 
    rn, bookNum, cateId, cateName, subCateId, bookTitle, 
from
(
    select 
        rownum as rn, b.bookNo as bookNum, c.cate_id as cateId, c.cate_name as cateName, s.subCate_id as subCateId, s.subCate_name as subCateName, b.bookName as bookTitle
        author as writer, publisher as , bookInfo as content, bookImage bookImg, price as bookprice, regDate as rDate
    from 
        book_table b 
    inner join book_category c on b.cate_id = c.cate_id 
    inner join book_subCategory s on b.subCate_id = s.subCate_id
    where rownum <= 20
    and b.bookName like '%%' and c.cate_id = 'information_technology' and s.subCate_id ='programming_language'
)
where rn > 10;

select 
    rn, bookNo, cate_id, subCate_id, bookName, author, publisher, bookInfo, bookImage, price, regDate
from
(
    select 
        rownum as rn, bookNo, cate_id, subCate_id, bookName, author, publisher, bookInfo, bookImage, price, regDate
    from 
        book_table
    where rownum <= 10
)
where rn > 0;