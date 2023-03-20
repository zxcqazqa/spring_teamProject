DECLARE
    I NUMBER(5); 
BEGIN
    -- IT / 프로그래밍언어 
    FOR i IN 1 .. 88
    LOOP
        INSERT INTO book_table(bookNo, cate_id, subCate_id, bookName, author, publisher,take,takePrice)
        VALUES (bookNo_seq.NEXTVAL,'information_technology','programming_language', '이것이 자바다-'||I, '신용권','한빛미디어','대여',1000); 
    END LOOP; 
    
   -- IT / 데이터베이스  
    FOR i IN 1 .. 84
    LOOP
        INSERT INTO book_table(bookNo, cate_id, subCate_id, bookName, author, publisher,take,takePrice)
        VALUES (bookNo_seq.NEXTVAL,'information_technology','database', '이것이 오라클이다-'||I, '우재남', '한빛미디어','대여',1000); 
    END LOOP; 
    
    -- IT / 웹사이트 
    FOR i IN 1 .. 108
    LOOP
        INSERT INTO book_table(bookNo, cate_id, subCate_id, bookName, author, publisher,take,takePrice)
        VALUES (bookNo_seq.NEXTVAL,'information_technology','website', 'Do it! 자바스크립트 + 제이쿼리 입문-'||I, '정인용','이지스퍼블리싱','대여',1000); 
    END LOOP;     
         
END;