files=`git ls-files .. | grep htm`
for i in $files
do
	fn=$fn\ $i
	if [[ $fn == *.htm ]]
	then
		fn=${fn%.htm}
		fn=`echo $fn | cut -b 1-`
		dfn=`basename "$fn"`
		echo $dfn
		prctime=0
		if [ -f "$dfn.prc" ] ; then prctime=`date -r "$dfn.prc" +%s` ; fi
		htmtime=`date -r "$fn.htm" +%s`
		jpgtime=$(date -r "$fn.jpg" +%s)
		if [[ $htmtime -gt $prctime || $jpgtime -gt $prctime ]]
		then
			pushd ${fn%/*}
			../kindlegen -c1 -o "$dfn.prc" "$dfn.htm" | tee "../build/$dfn.log"
			mv "$dfn.prc" "../build/$dfn.prc"
			popd
		fi
		fn=
	fi;
done
