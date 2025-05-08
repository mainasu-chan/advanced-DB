/*学籍番号：
氏　　名：
--------------------------------------------------
・学籍番号と氏名を入力してください
・SQL文を入力し提出してください
--------------------------------------------------

問1　部署が決まっている社員の一覧表を表示
			表示列：社員番号、氏名、部署番号、部署名*/

SELECT
    e.e_no,
    e.e_name,
    e.d_code,
    d.d_name
FROM
    employee e
JOIN
    dept d ON e.d_code = d.d_code
WHERE
    e.d_code IS NOT NULL;
/*問2　全社員の一覧表を表示
			表示列：社員番号、氏名、部署番号、部署名*/
SELECT
    e.e_no,
    e.e_name,
    e.d_code,
    d.d_name
FROM
    employee e
LEFT JOIN
    dept d ON e.d_code = d.d_code;

/*問3　資格を取得している社員を表示
　　（複数の資格を取得者している社員は1行で良い）
			表示列：社員番号、氏名*/
SELECT DISTINCT
    g.e_no,
    e.e_name
FROM
    get_cert g
JOIN
    employee e ON g.e_no = e.e_no;

/*問4　資格を取得していない社員を表示
			表示列：社員番号、氏名*/
SELECT
    e.e_no,
    e.e_name
FROM
    employee e
WHERE
    NOT EXISTS (
        SELECT 1
        FROM get_cert g
        WHERE g.e_no = e.e_no
    );	

/*問5　取得されている資格を表示（複数取得されている資格は1行で良い）
			表示列：資格番号、資格名*/
SELECT DISTINCT
    c.c_code,
    c.c_name
FROM
    get_cert g
JOIN
    cert c ON g.c_code = c.c_code;

/*問6　誰も取得していない資格を表示
			表示列：資格番号、資格名*/
SELECT
    c.c_code,
    c.c_name
FROM
    cert c
WHERE
    NOT EXISTS (
        SELECT 1
        FROM get_cert g
        WHERE g.c_code = c.c_code
    );

/*問7　給与が256,000円以上の社員を給与の高い順に表示
			表示列：社員番号、氏名、役職番号、役職名、給与*/
SELECT
    e.e_no,
    e.e_name,
    e.t_code,
    t.t_name,
    e.salary
FROM
    employee e
LEFT JOIN
    title t ON e.t_code = t.t_code
WHERE
    e.salary >= 256000
ORDER BY
    e.salary DESC;

/*問8　資格を取得していない社員を部署ごとにまとめた表を表示
			表示列：部署番号、未取得者数(別名定義)*/
SELECT
    e.d_code,
    COUNT(e.e_no) AS 未取得者数
FROM
    employee e
WHERE
    NOT EXISTS (
        SELECT 1
        FROM get_cert g
        WHERE g.e_no = e.e_no
    )
GROUP BY
    e.d_code;

/*問9　すべての資格の資格番号と資格名と取得人数を表示
			表示列：資格番号、資格名、取得人数（別名定義）*/
SELECT
    c.c_code,
    c.c_name,
    COUNT(g.e_no) AS 取得人数
FROM
    cert c
LEFT JOIN
    get_cert g ON c.c_code = g.c_code
GROUP BY
    c.c_code, c.c_name;

/*問10　全社員の資格取得数と資格手当の合計を表示
			表示列：社員番号、氏名、資格取得数（別名定義）、資格手当合計（別名定義）*/
SELECT
    e.e_no,
    e.e_name,
    COUNT(g.c_code) AS 資格取得数,
    SUM(c.c_allowance) AS 資格手当合計
FROM
    employee e
LEFT JOIN
    get_cert g ON e.e_no = g.e_no
LEFT JOIN
    cert c ON g.c_code = c.c_code
GROUP BY
    e.e_no, e.e_name;