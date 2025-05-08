/*学籍番号：
氏　　名：
--------------------------------------------------
・学籍番号と氏名を入力してください
・SQL文を入力し提出してください
--------------------------------------------------

/*問1　社員番号「E0101」の役職名をサブクエリを使って取得
	表示列：役職番号、役職名*/
SELECT
    t.t_code,
    t.t_name
FROM
    title t
WHERE
    t.t_code = (SELECT t_code FROM employee WHERE e_no = 'E0101');

/*問2　最も高い給与を支給されている社員をサブクエリを使って取得
	表示列：社員番号、氏名、給与*/
SELECT
    e.e_no,
    e.e_name,
    e.salary
FROM
    employee e
WHERE
    e.salary = (SELECT MAX(salary) FROM employee);

/*問3　平均給与以上の給与を支給されている社員をサブクエリを使って取得
	表示列：社員番号、氏名、給与*/
SELECT
    e.e_no,
    e.e_name,
    e.salary
FROM
    employee e
WHERE
    e.salary >= (SELECT AVG(salary) FROM employee);

/*問4　資格を取得している社員をサブクエリを使って取得
	表示列：社員番号、氏名*/
SELECT
    e.e_no,
    e.e_name
FROM
    employee e
WHERE
    e.e_no IN (SELECT e_no FROM get_cert);

/*問5　資格者のいない資格番号と資格名をサブクエリを使って取得
	表示列：社員番号、氏名*/
SELECT
    c.c_code,
    c.c_name
FROM
    cert c
WHERE
    c.c_code NOT IN (SELECT c_code FROM get_cert);

/*問6　部署ごとの平均給与のすべて以上の給与を支給されている社員をサブクエリを使って取得し、
　　　給与の高い順に並べ替える（同じ給与の社員が存在した場合は、社員番号の若い順に並べ替える）*/
SELECT e_no, e_name, salary
FROM employee
WHERE d_code <> ''
  AND salary >= (
    SELECT AVG(salary)
    FROM employee AS e2
    WHERE e2.d_code = employee.d_code
)
ORDER BY salary DESC, e_no ASC;


/*問7　給与が全社員の平均給与のマイナス3万円以上で
　　　　　　全社員の平均給与のプラス3万円以下の社員をサブクエリを使って取得
	表示列：社員番号、氏名、給与*/

SELECT
    e.e_no,
    e.e_name,
    e.salary
FROM
    employee e
WHERE
    e.salary BETWEEN (SELECT AVG(salary) - 30000 FROM employee) AND (SELECT AVG(salary) + 30000 FROM employee);
/*問8　資格取得者が5人以上いる資格を持つ社員をサブクエリを使って取得
	表示列：社員番号、氏名*/
SELECT
    e.e_no,
    e.e_name
FROM
    employee e
WHERE
    e.e_no IN (
        SELECT
            g.e_no
        FROM
            get_cert g
        JOIN (
            SELECT
                c_code
            FROM
                get_cert
            GROUP BY
                c_code
            HAVING
                COUNT(*) >= 5
        ) AS popular_certs ON g.c_code = popular_certs.c_code
    );
