DECLARE
    I NUMBER(5); 
BEGIN
    -- IT / ���α׷��־�� 
    FOR i IN 1 .. 88
    LOOP
        INSERT INTO book_table(bookNo, cate_id, subCate_id, bookName, author, publisher,take,takePrice)
        VALUES (bookNo_seq.NEXTVAL,'information_technology','programming_language', '�̰��� �ڹٴ�-'||I, '�ſ��','�Ѻ��̵��','�뿩',1000); 
    END LOOP; 
    
   -- IT / �����ͺ��̽�  
    FOR i IN 1 .. 84
    LOOP
        INSERT INTO book_table(bookNo, cate_id, subCate_id, bookName, author, publisher,take,takePrice)
        VALUES (bookNo_seq.NEXTVAL,'information_technology','database', '�̰��� ����Ŭ�̴�-'||I, '���糲', '�Ѻ��̵��','�뿩',1000); 
    END LOOP; 
    
    -- IT / ������Ʈ 
    FOR i IN 1 .. 108
    LOOP
        INSERT INTO book_table(bookNo, cate_id, subCate_id, bookName, author, publisher,take,takePrice)
        VALUES (bookNo_seq.NEXTVAL,'information_technology','website', 'Do it! �ڹٽ�ũ��Ʈ + �������� �Թ�-'||I, '���ο�','�������ۺ���','�뿩',1000); 
    END LOOP;     
         
END;