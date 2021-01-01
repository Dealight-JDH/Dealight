                       </div>
                </div>
                </div>
            </div> <!-- end main box -->
        </main>
        <script>
        $(".manage_side_menu_box").on("click",(e) => {
        	
        	console.log(e.currentTarget);
        	
        	location.href = $(e.currentTarget).find("a").attr("href");
        	
        });
        </script>