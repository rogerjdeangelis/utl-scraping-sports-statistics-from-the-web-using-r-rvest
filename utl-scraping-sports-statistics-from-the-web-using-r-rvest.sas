%let pgm=utl-scraping-sports-statistics-from-the-web-using-r-rvest;

Scraping sports statistics from the web using r

github
https://tinyurl.com/5ew5psma
https://github.com/rogerjdeangelis/utl-scraping-sports-statistics-from-the-web-using-r-rvest

Stackoverflow R
https://stackoverflow.com/search?q=user:5792244+[web-scraping]

Related web Scraping Repos on ens

/*               _     _
 _ __  _ __ ___ | |__ | | ___ _ __ ___
| `_ \| `__/ _ \| `_ \| |/ _ \ `_ ` _ \
| |_) | | | (_) | |_) | |  __/ | | | | |
| .__/|_|  \___/|_.__/|_|\___|_| |_| |_|
|_|
*/

/************************************************************************************************************************************/
/*                                                                                                                                  */
/*                INPUT                                              PROCESS                                        OUTPUT          */
/*                =====                                              =======                                        ======          */
/*   https://www.hockey-reference.com/leagues/NHL_2025.html                                                                         */
/*                                                                                                                                  */
/*   THIS IS WHAT THE WEB PAGE LOOKS LIKE                                                                                           */
/*   (… means truncated)                                                                                                            */
/*-------------------------------------------------------------------------------------------------------------------------------   */
/*                                              |                                                          |                        */
/*             W     L       ...    SRS     SOS |                                                          | SD1.WANT Obs 18        */
/*                                              |                                                          |                        */
/*  Atlantic… Atla… Atla…  ...   Atla…  Atlan…  |%utl_rbeginx;                                             | MIDDLE Obsevation      */
/*  Toronto … 18    10     ...    0.33   .600   |parmcards4;                                               |                        */
/*  Florida … 18    11     ...    0.36   .548   |library(rvest)                                            | TEAMS  C21   Montreal… */
/*  Boston B… 16    13     ...   -0.72   .500   |source("c:/oto/fn_tosas9x.R")                             | GP     C21   30        */
/*  Tampa Ba… 16    10     ...    1.30   .589   |url <-                                                    | W      C21   11        */
/*  Ottawa S… 15    13     ...    0.06   .517   | "https://www.hockey-reference.com/leagues/NHL_2025.html" | L      C21   16        */
/*  Detroit … 12    14     ...   -0.74   .383   |page<-read_html(url)                                      | OL     C21   3         */
/*  Buffalo … 11    15     ...   -0.39   .367   |want<-page %>% html_table()                               | PTS    C21   25        */
/*  Montreal… 11    16     ...   -1.06   .367   |want<-as.data.frame(want[[1]])                            | PTS_   C21   .417      */
/*  Metropol… Metr… Metr…  ...    Metr…  Metr…  |colnames(want)[1]<-"TEAMS" # first col has missing name   | GF     C21   82        */
/*  Washingt… 21    6      ...    1.41   .724   |str(want)                                                 | GA     C21   113       */
/*  New Jers… 20    10     ...    0.84   .606   |fn_tosas9x(                                               | SRS    C21   -1.06     */
/*  Carolina… 18    10     ...    0.66   .638   |      inp    = want                                       | SOS    C21   -0.02     */
/*  Philadel… 14    13     ...   -0.41   .435   |     ,outlib ="d:/sd1/"                                   | RPt_   C21   .367      */
/*  New York… 15    13     ...   -0.10   .517   |     ,outdsn ="want"                                      | RW     C21   8         */
/*  New York… 12    12     ...   -0.48   .371   |     )                                                    | RgRec  C21   8-16-6    */
/*  Pittsbur… 13    14     ...   -0.75   .422   |;;;;                                                      | RgPt_  C21   .367      */
/*  Columbus… 12    13     ...   -0.21   .383   |%utl_rendx;                                               |                        */
/*                                              |                                                          |                        */
/************************************************************************************************************************************/

/*                   _
(_)_ __  _ __  _   _| |_
| | `_ \| `_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
*/

/**************************************************************************************************************************/
/*                                                                                                                        */
/*  THIS IS WHAT THE WEB PAGE LOOKS LIKE                                                                                  */
/*                                                                                                                        */
/*  https://www.hockey-reference.com/leagues/NHL_2025.html                                                                */
/*                                                                                                                        */
/*                                                                                                                        */
/*             GP    W     L     OL    PTS  `PTS%   GF    GA    SRS   SOS   RPt%                                          */
/*                                                                                                                        */
/*  Atlantic… Atla… Atla… Atla… Atla… Atla… Atlan… Atla… Atla… Atla… Atla… Atlan…                                         */
/*  Toronto … 30    18    10    2     38    .633   87    78    0.33  0.03  .600                                           */
/*  Florida … 31    18    11    2     38    .613   108   99    0.36  0.07  .548                                           */
/*  Boston B… 32    16    13    3     35    .547   82    101   -0.72 -0.13 .500                                           */
/*  Tampa Ba… 28    16    10    2     34    .607   112   82    1.30  0.23  .589                                           */
/*  Ottawa S… 30    15    13    2     32    .533   93    89    0.06  -0.07 .517                                           */
/*  Detroit … 30    12    14    4     28    .467   78    94    -0.74 -0.20 .383                                           */
/*  Buffalo … 30    11    15    4     26    .433   89    99    -0.39 -0.06 .367                                           */
/*  Montreal… 30    11    16    3     25    .417   82    113   -1.06 -0.02 .367                                           */
/*  Metropol… Metr… Metr… Metr… Metr… Metr… Metro… Metr… Metr… Metr… Metr… Metro…                                         */
/*  Washingt… 29    21    6     2     44    .759   115   77    1.41  0.10  .724                                           */
/*  New Jers… 33    20    10    3     43    .652   110   86    0.84  0.11  .606                                           */
/*  Carolina… 29    18    10    1     37    .638   104   86    0.66  0.04  .638                                           */
/*  Philadel… 31    14    13    4     32    .516   93    106   -0.41 0.01  .435                                           */
/*  New York… 29    15    13    1     31    .534   90    88    -0.10 -0.17 .517                                           */
/*  New York… 31    12    12    7     31    .500   83    94    -0.48 -0.13 .371                                           */
/*  Pittsbur… 32    13    14    5     31    .484   97    121   -0.75 0.00  .422                                           */
/*  Columbus… 30    12    13    5     29    .483   100   107   -0.21 0.02  .383                                           */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*
 _ __  _ __ ___   ___ ___  ___ ___
| `_ \| `__/ _ \ / __/ _ \/ __/ __|
| |_) | | | (_) | (_|  __/\__ \__ \
| .__/|_|  \___/ \___\___||___/___/
|_|
*/

%utl_rbeginx;
parmcards4;
library(rvest)
source("c:/oto/fn_tosas9x.R")
url <-
 "https://www.hockey-reference.com/leagues/NHL_2025.html"
page<-read_html(url)
want<-page %>% html_table()
want<-as.data.frame(want[[1]])
colnames(want)[1]<-"TEAMS" # first col has missing name
str(want)
fn_tosas9x(
      inp    = want
     ,outlib ="d:/sd1/"
     ,outdsn ="want"
     )
;;;;
%utl_rendx;

options ls=255;
proc print data=sd1.want(where=(index(teams,'Divis')=0))     HEADING=VERTICAL width=min;
run;quit;;


/**************************************************************************************************************************/
/*                                                                                                                        */
/*  R                                                                                                                     */
/*                                                                                                                        */
/*              GP    W     L     OL    PTS  `PTS%   GF    GA    SRS   SOS   RPt%                                         */
/*                                                                                                                        */
/*   Atlantic… Atla… Atla… Atla… Atla… Atla… Atlan… Atla… Atla… Atla… Atla… Atlan…                                        */
/*   Toronto … 30    18    10    2     38    .633   87    78    0.33  0.03  .600                                          */
/*   Florida … 31    18    11    2     38    .613   108   99    0.36  0.07  .548                                          */
/*   Boston B… 32    16    13    3     35    .547   82    101   -0.72 -0.13 .500                                          */
/*   Tampa Ba… 28    16    10    2     34    .607   112   82    1.30  0.23  .589                                          */
/*   Ottawa S… 30    15    13    2     32    .533   93    89    0.06  -0.07 .517                                          */
/*   Detroit … 30    12    14    4     28    .467   78    94    -0.74 -0.20 .383                                          */
/*   Buffalo … 30    11    15    4     26    .433   89    99    -0.39 -0.06 .367                                          */
/*   Montreal… 30    11    16    3     25    .417   82    113   -1.06 -0.02 .367                                          */
/*   Metropol… Metr… Metr… Metr… Metr… Metr… Metro… Metr… Metr… Metr… Metr… Metro…                                        */
/*   Washingt… 29    21    6     2     44    .759   115   77    1.41  0.10  .724                                          */
/*   New Jers… 33    20    10    3     43    .652   110   86    0.84  0.11  .606                                          */
/*   Carolina… 29    18    10    1     37    .638   104   86    0.66  0.04  .638                                          */
/*   Philadel… 31    14    13    4     32    .516   93    106   -0.41 0.01  .435                                          */
/*   New York… 29    15    13    1     31    .534   90    88    -0.10 -0.17 .517                                          */
/*   New York… 31    12    12    7     31    .500   83    94    -0.48 -0.13 .371                                          */
/*   Pittsbur… 32    13    14    5     31    .484   97    121   -0.75 0.00  .422                                          */
/*   Columbus… 30    12    13    5     29    .483   100   107   -0.21 0.02  .383                                          */
/*                                                                                                                        */
/*                                                                                                                        */
/*  SAS (Slight editing easy to do with datastep)                                                                         */
/*                                                                                                                        */
/*            T                                                                                            R        R     */
/*            E                                    P                                       R               g        g     */
/*            A                             P      T                      S        S       P               R        P     */
/*            M                                    S       G      G       R        O       t      R        e        t     */
/*            S            P  W  L     L    S      %       F      A       S        S       %      W        c        %     */
/*                                                                                                                        */
/*  Atlantic Division                                                                                                     */
/*                                                                                                                        */
/*  Toronto Maple Leafs    30 18 10    2    38    .633    87     78     0.33     0.03     .600    15    15-10-5    .583   */
/*  Florida Panthers       31 18 11    2    38    .613    108    99     0.36     0.07     .548    15    15-11-5    .565   */
/*  Boston Bruins          32 16 13    3    35    .547    82     101    -0.72    -0.13    .500    11    11-13-8    .469   */
/*  Tampa Bay Lightning    28 16 10    2    34    .607    112    82     1.30     0.23     .589    13    13-10-5    .554   */
/*  Ottawa Senators        30 15 13    2    32    .533    93     89     0.06     -0.07    .517    12    12-13-5    .483   */
/*  Detroit Red Wings      30 12 14    4    28    .467    78     94     -0.74    -0.20    .383    9     9-14-7     .417   */
/*  Buffalo Sabres         30 11 15    4    26    .433    89     99     -0.39    -0.06    .367    8     8-15-7     .383   */
/*                                                                                                                        */
/*  Metropolitan Division                                                                                                 */
/*  Montreal Canadiens     30 11 16    3    25    .417    82     113    -1.06    -0.02    .367    8     8-16-6     .367   */
/*  Washington Capitals    29 21 6     2    44    .759    115    77     1.41     0.10     .724    18    18-6-5     .707   */
/*  New Jersey Devils      33 20 10    3    43    .652    110    86     0.84     0.11     .606    19    19-10-4    .636   */
/*  Carolina Hurricanes    29 18 10    1    37    .638    104    86     0.66     0.04     .638    16    16-10-3    .603   */
/*  Philadelphia Flyers    31 14 13    4    32    .516    93     106    -0.41    0.01     .435    7     7-13-11    .403   */
/*  New York Rangers       29 15 13    1    31    .534    90     88     -0.10    -0.17    .517    15    15-13-1    .534   */
/*  New York Islanders     31 12 12    7    31    .500    83     94     -0.48    -0.13    .371    9     9-12-10    .452   */
/*  Pittsburgh Penguins    32 13 14    5    31    .484    97     121    -0.75    0.00     .422    9     9-14-9     .422   */
/*  Columbus Blue Jackets  30 12 13    5    29    .483    100    107    -0.21    0.02     .383    10    10-13-7    .450   */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*        _       _           _
 _ __ ___| | __ _| |_ ___  __| |  _ __ ___ _ __   ___  ___
| `__/ _ \ |/ _` | __/ _ \/ _` | | `__/ _ \ `_ \ / _ \/ __|
| | |  __/ | (_| | ||  __/ (_| | | | |  __/ |_) | (_) \__ \
|_|  \___|_|\__,_|\__\___|\__,_| |_|  \___| .__/ \___/|___/
                                          |_|
*/
REPO
-------------------------------------------------------------------------------------------------------------------------------------
https://github.com/rogerjdeangelis/utl-Web-Scraping-data-from-Australian-Open-stats
https://github.com/rogerjdeangelis/utl-identifying-html-nodes-and-extracting-specific-information-scraping-html
https://github.com/rogerjdeangelis/utl-identifying-the-html-table-and-exporting-to-spss-then-sas-scraping
https://github.com/rogerjdeangelis/utl-locating-the-html-node-and-web-scrape-the-html-table
https://github.com/rogerjdeangelis/utl-python-scrape-web-page-source-and-save-to-local-file-like-view-source-but-programatically
https://github.com/rogerjdeangelis/utl-sas-scraping-connections-on-linkedIn-and-output-in-sas-dataset
https://github.com/rogerjdeangelis/utl-scrape-weather-conditions-for-a-past-march-red-sox-vs-orioles-game-
https://github.com/rogerjdeangelis/utl-scraping-AI-results-without-restriction-or-API-with-powershell-and-perplexity
https://github.com/rogerjdeangelis/utl-scraping-a-single-indirect-html-reference-using-python-beautiful-soup-and-request-packages
https://github.com/rogerjdeangelis/utl-scraping-a-web-page-with-three-by-three-set-of-finacial-tables
https://github.com/rogerjdeangelis/utl-scraping-pdf-output-for-pdf-tables-and-lists
https://github.com/rogerjdeangelis/utl-scraping-san-francisco-hourly-weather-forecast-reading-xml-on-the-web
https://github.com/rogerjdeangelis/utl-scraping-server-screens-when-Copy-Print-PageSource-are-disabled-python-tesseract
https://github.com/rogerjdeangelis/utl-using-r-rvest-to-scrape-the-web-for-brazil-world-cup-performance
https://github.com/rogerjdeangelis/utl-web-scaping-Loop-over-many-URLs-scrape-parse-extract-nodes-and-put-into-a-sas-table
https://github.com/rogerjdeangelis/utl-web-scraping-USDOT-vehicle-inspections-and-fatalities
https://github.com/rogerjdeangelis/utl-web-scraping-a-large-wikipedia-html-table-user-R-rvest
https://github.com/rogerjdeangelis/utl-web-scraping-spains-grananda-soccer-team-players
https://github.com/rogerjdeangelis/utl_scrape_javascript_converting_table_to_sas_dataset_no_browser
https://github.com/rogerjdeangelis/utl_scraping_javascript_generated_html_web_pages
https://github.com/rogerjdeangelis/utl_scraping_mutiple_web_tables_and_creating_seven_database_tables
https://github.com/rogerjdeangelis/utl_web_scrape_23_separate_pages_one_per_state_for_all_whole_food_store_addresses
https://github.com/rogerjdeangelis/utl_web_scraping_programatically_using_a_web_search_box_and_retrieve_information
https://github.com/rogerjdeangelis/utl_web_scraping_top_cnn_stories
https://github.com/rogerjdeangelis/utl_web_scraping_web_pages_for_the_latest_news_on_the_food_shortage_in_yemen
https://github.com/rogerjdeangelis/utl_webscraping_www.treasury.gov__xml_page_of_interest_rates


/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/
