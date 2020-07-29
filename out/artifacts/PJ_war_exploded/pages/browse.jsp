<?php session_start();
require_once dirname(__FILE__).'/'.'../php/config.php';

try {
    $pdo = new PDO(DBCONNSTRING,DBUSER,DBPASS);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    $hotThemesql = "select a.Content, COUNT(a.Content) from travelimage as a GROUP by a.Content Order by COUNT(a.Content) DESC ";
    $hotCitysql = "select c.AsciiName, COUNT(a.CityCode) from travelimage as a , geocities as c Where  a.CityCode = c.GeoNameID GROUP by c.AsciiName Order by COUNT(a.CityCode) DESC ";
    $hotCountrysql = "select b.CountryName, COUNT(a.CountryCodeISO) from travelimage as a , geocountries as b  Where  a.CountryCodeISO = b.ISO GROUP by b.CountryName Order by COUNT(a.CountryCodeISO) DESC ";
?>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width">
    <title>Browse Projectouriscenary</title>
    <link rel="stylesheet" href="../css/browse.css">
    <script src='../../src/js/jquery-3.5.1.js'></script>
    <script src='../../src/js/vue.js'></script>
</head>

<body>
    <nav class="sky" id='nav' style="opacity: 0.8;">
        <ul>
            <nav_left></nav_left>
            <component v-bind:is="whichcomp"></component>
            <skin_changer></skin_changer>
        </ul>
    </nav>

    <main>
        <aside id='aside'>
            <div id="search-by-title">
                <table>
                    <thead>
                        <tr>
                            <th>Search by title</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>
                                <form action="/src/php/Search/singleSearch.php" method="post">
                                    <input type="text" name="Title" required>
                                    <button type="submit"><svg t="1584804835687" class="icon"  width="20px" height="20px" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="2983" >
                                            <path
                                                d="M1005.312 914.752l-198.528-198.464A448 448 0 1 0 0 448a448 448 0 0 0 716.288 358.784l198.4 198.4a64 64 0 1 0 90.624-90.432zM448 767.936A320 320 0 1 1 448 128a320 320 0 0 1 0 640z"
                                                fill="#262626" p-id="2984">
                                            </path>
                                        </svg></button></form>
                            </td>
                        </tr>
                    </tbody>
                </table>
                </form>


            </div>
            <div id="hot-themes">
                <form action="/src/php/Search/singleSearch.php" method="post" name="themeForm" id="themeForm">
                    <input hidden='hidden' name='theme'>
                <table>
                    <thead>
                        <tr>
                            <th>Hot Themes</th>
                        </tr>
                    </thead>
                    <tbody>



                    <?php
                    // Hot theme 生成 3个
                    $hotResult = $pdo->query($hotThemesql);


                    for ($i = 0; $i < 3; $i++){
                        $row = $hotResult->fetch();
                        echo "<tr><td><span onclick= \"sendSingle('theme','".$row['Content']."')\">".$row['Content']."</span></td></tr>";

                    }

                    ?>





                    </tbody>
                </table>

                </form>
            </div>
            <div id="hot-countries">
                <form action="/src/php/Search/singleSearch.php" method="post" name="countryForm" id="countryForm">
                    <input hidden='hidden' name='country'>
                <table>
                    <thead>
                        <tr>
                            <th>Hot countries</th>
                        </tr>
                    </thead>
                    <tbody>
                    <?php
                    // hot Country 生成 4个
                    $hotResult = $pdo->query($hotCountrysql);
                    for ($i = 0; $i < 4; $i++){
                        $row = $hotResult->fetch();
                        echo "<tr><td><span onclick= \"sendSingle('country','".$row['CountryName']."')\">".$row['CountryName']."</span></td></tr>";

                    }
                    ?>


                    </tbody>
                </table>
                </form>
            </div>
            <div id="hot-cities">
                <form action="/src/php/Search/singleSearch.php" method="post" name="cityForm" id="cityForm">
                    <input hidden='hidden' name='city'>
                <table>
                    <thead>
                        <tr>
                            <th>Hot cities</th>
                        </tr>
                    </thead>
                    <tbody>
                    <?php
                    // hot city 生成 6
                    $hotResult = $pdo->query($hotCitysql);
                    for ($i = 0; $i < 4; $i++){
                        $row = $hotResult->fetch();
                        echo "<tr><td><span onclick= \"sendSingle('city','".$row['AsciiName']."')\">".$row['AsciiName']."</span></td></tr>";
                    }
                    $pdo = null;


                    }
                    catch (PDOException $e) {
                        die($e->getMessage());
                    }

                    ?>
                    </tbody>
                </table>
                </form>
            </div>

        </aside>
        <section>
            <table>

                <thead>
                    <tr>
                        <th>
                            Filter</th>
                    </tr>
                    <tr>
                        <td>
                            <form name="form1" method="post" action="/src/php/Search/multiSelector.php">
                                <select name="theme" id="theme">
                                    <option value="">Choose a theme</option>
                                    <option value="scenery">Scenery</option>
                                    <option value="modern">Modern</option>
                                    <option value="religion">Religion</option>
                                    <option value="relic">Relic</option>
                                    <option value="romantic">Romantic</option>
                                </select>
                                <select name="country" id="country"></select>
                                <select name="city" id="city"></select>
                                <button type="submit" >Filter</button>
                            </form>
                        </td>
                    </tr>

                </thead>
                <tbody>
                    <tr>
                        <td style="text-align: center;">
                            <svg id='placeholder' t="1591878697641" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="6001" width="200" height="200"><path d="M855.6 427.2H168.5c-12.7 0-24.4 6.9-30.6 18L4.4 684.7C1.5 689.9 0 695.8 0 701.8v287.1c0 19.4 15.7 35.1 35.1 35.1H989c19.4 0 35.1-15.7 35.1-35.1V701.8c0-6-1.5-11.8-4.4-17.1L886.2 445.2c-6.2-11.1-17.9-18-30.6-18zM673.4 695.6c-16.5 0-30.8 11.5-34.3 27.7-12.7 58.5-64.8 102.3-127.2 102.3s-114.5-43.8-127.2-102.3c-3.5-16.1-17.8-27.7-34.3-27.7H119c-26.4 0-43.3-28-31.1-51.4l81.7-155.8c6.1-11.6 18-18.8 31.1-18.8h622.4c13 0 25 7.2 31.1 18.8l81.7 155.8c12.2 23.4-4.7 51.4-31.1 51.4H673.4zM819.9 209.5c-1-1.8-2.1-3.7-3.2-5.5-9.8-16.6-31.1-22.2-47.8-12.6L648.5 261c-17 9.8-22.7 31.6-12.6 48.4 0.9 1.4 1.7 2.9 2.5 4.4 9.5 17 31.2 22.8 48 13L807 257.3c16.7-9.7 22.4-31 12.9-47.8zM375.4 261.1L255 191.6c-16.7-9.6-38-4-47.8 12.6-1.1 1.8-2.1 3.6-3.2 5.5-9.5 16.8-3.8 38.1 12.9 47.8L337.3 327c16.9 9.7 38.6 4 48-13.1 0.8-1.5 1.7-2.9 2.5-4.4 10.2-16.8 4.5-38.6-12.4-48.4zM512 239.3h2.5c19.5 0.3 35.5-15.5 35.5-35.1v-139c0-19.3-15.6-34.9-34.8-35.1h-6.4C489.6 30.3 474 46 474 65.2v139c0 19.5 15.9 35.4 35.5 35.1h2.5z" p-id="6002" fill="#5a5252e0"></path></svg>
                            <ul id="filter_result">
                                <?php
                                // 分页输出代码
                                $pageSize = 9;
                                if (isset($_SESSION['search'])){
                                    $sess = $_SESSION['search'];
                                    $totalCount = $sess['Count'];
                                    if($totalCount != 0) echo "<script>document.getElementById('placeholder').style = 'display:none';</script>";
                                    // 单页
                                    if ($totalCount <= $pageSize){
                                        $sess['totalPage'] = 1;
                                        output(0,$totalCount);
                                    }else {
                                        // 前几页index: 9currentPage-9 ~ 9*currentPage-1 末页index: 9*totalPage - 9 ~ count
                                        $sess['totalPage'] = (int)(($totalCount%$pageSize==0)?($totalCount/$pageSize):($totalCount/$pageSize+1));
                                        if ($sess['currentPage'] == $sess['totalPage']){
                                            output($pageSize*$sess['totalPage']-$pageSize,$totalCount);
                                        }else {
                                            output($pageSize*$sess['currentPage']-$pageSize,$pageSize*$sess['currentPage']);
                                        }
                                    }
                                }

                                function output($start,$endNotIn){
                                    for ($k = $start; $k < $endNotIn; $k++){
                                        $img = "<img src='/images/normal/medium/".$_SESSION['search']['PATH'][$k]."'>";
                                        echo "<li><a href='/src/html/detail.php?ImageID=".$_SESSION['search']['ImageID'][$k]."'>".$img."</a> </li>";
                                    }

                                }

                                ?>

                            </ul>
                        </td>
                    </tr>
                </tbody>
                <tfoot>
                <tr>
                    <td>

                        <blockquote id='pages_number'>
                            <?php

                            if (isset($_SESSION['search'])){
                                if ($totalCount <= $pageSize){
                                    echo "<a href='browse.php' class='highlight'>1</a>";
                                }else {
                                    // 前几页index: 9currentPage-9 ~ 9*currentPage-1 末页index: 9*totalPage - 9 ~ count
                                    if ($sess['totalPage'] > 5) pages(5);
                                    else pages($sess['totalPage']);
                                    echo "<script>var current = document.getElementById('page".$sess['currentPage']."');
                                        current.classList.add('highlight');
                                        </script>";
                                }
                            }
                            function pages($totalPage){
                                $urlPart = '/src/php/Display/jumpPage.php';
                                 echo "<a href='/src/php/Display/toPreviousPage.php'>&lt&lt</a>";
                                 for ($p = 1; $p <= $totalPage; $p++){
                                     echo "<a href='".$urlPart."?".$p."' id='page".$p."'>".$p."</a>";
                                 }
                                 echo "<a href='/src/php/Display/toNextPage.php'>&gt&gt</a>";
                            }


                            ?>
                        </blockquote>
                    </td>
                </tr>
                </tfoot>

            </table>
        </section>

    </main>
  



</body>

<footer id="footer"></footer>
<div class="float-button">
    <ul>
        <li><a id="unfold"><svg id='unfold-logo' t=" 1586273115456" class="icon down" viewBox="0 0 1024 1024" version="1.1"
                xmlns="http://www.w3.org/2000/svg" p-id="2487">
                <path
                    d="M684.691107 434.776198 513.02433 604.484368 341.355505 434.776198c-11.850909-11.713786-31.06553-11.713786-42.916439 0-11.850909 11.716856-11.850909 30.711466 0 42.427298l193.126532 190.918237c11.850909 11.713786 31.06246 11.713786 42.916439 0l193.124486-190.918237c11.850909-11.716856 11.850909-30.711466 0-42.427298C715.756637 423.062412 696.540993 423.062412 684.691107 434.776198zM513.49812 63.075571c-246.687402 0-446.664969 199.980637-446.664969 446.664969S266.810718 956.405509 513.49812 956.405509c246.684332 0 446.664969-199.980637 446.664969-446.664969S760.182452 63.075571 513.49812 63.075571zM513.49812 900.5729c-215.851093 0-390.83236-174.981267-390.83236-390.83236S297.647027 118.90818 513.49812 118.90818s390.83236 174.981267 390.83236 390.83236S729.349213 900.5729 513.49812 900.5729z"
                    p-id="2488"></path></svg>
            </a>
        </li>
    </ul>
</div>
<script src="../js/nav&footer.js"></script>
<script src='../js/change_skin.js'></script>
<script src="../js/browse.js"></script>
<script src='../js/unfold.js'></script>


</html>