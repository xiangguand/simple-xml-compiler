#!/usr/bin/bash

# Define color codes
GREEN='\033[0;32m' # Green color
RED='\033[0;31m'   # Red color
NC='\033[0m'       # No color (to reset)

cmake -S . -B build -G"Ninja"
ninja -C build clean
ninja -C build

echo "===== Perfrom checker ====="
./build/checker
echo "===== Complete ====="


echo "===== Perfrom testing ====="
test_count=0
pass_count=0
fail_count=0
# Define the function with input argument
test() {
    input=$1
    expect=$2
    # Run the command with the input and capture its output
    output=$(./build/validator "$input")

    # Check if the output contains $2
    if [[ $output == $expect ]]; then
        echo -e "${GREEN}[PASS]${NC} $1"
        pass_count=$((pass_count+1))
    else
        echo -e "${RED}[FAIL]${NC} $1 Expect $2"
        fail_count=$((fail_count+1))
    fi
    test_count=$((test_count+1))
}

test "<Design><Code>hello world</Code></Design>" "Valid"
test "<Design><Code>hello world</Code></Design><People>" "Invalid"
test "<People><Design><Code>hello world</People></Code></Design>" "Invalid"
test "<People age=”1”>hello world</People>" "Invalid"
test "<a></a>" "Valid"
test "<a><b><d></d></b><c></c></a>" "Valid"
test "<<a></a>" "Invalid"
test "<a>></a>" "Invalid"
test "<a><</a>" "Invalid"
test "<a><//a>" "Invalid"
test "<a></a>>" "Invalid"
test "<a><b>Something</b></a>" "Valid"
test "a><b>Something</b</a>" "Invalid"
test "<a<b>Something</b</a>" "Invalid"
test "<a><bSomething</b></a>" "Invalid"
test "<a><b>Something/b></a>" "Invalid"
test "<a><b>Something<b></a>" "Invalid"
test "<a><b>Something</b</a>" "Invalid"
test "<a><b>Something</b>/a>" "Invalid"
test "<a><b>Something</b><a>" "Invalid"
test "<a><b>Something</b></>" "Invalid"
test "<a><b>Something</b></a" "Invalid"
test "<a>" "Invalid"
test "<a" "Invalid"
test "a" "Invalid"
test "" "Invalid"
test " " "Invalid"
test "a>" "Invalid"
test "<a><a>" "Invalid"
test "<a><a/>" "Invalid"
test "<a>/<a>" "Invalid"
test "<a><a" "Invalid"
test "<a></a" "Invalid"
test "<a><b><c><d></d></c></b></a>" "Valid"
test "<a><b><c><d><e></e></d></c></b></a>" "Valid"
test "<a><b><c><d><abcdef></abcdef></d></c></b></a>" "Valid"
test "<a><b><c><d><abcdef><a></a></abcdef></d></c></b></a>" "Valid"
test "<a><b><c><d><accdef><a></a></abcdef></d></c></b></a>" "Invalid"

test "<jjjmn>i<zcgdl>pso<gi>yvaz<oq>q<txmsn>tvknz<shte>lp<jlh>mgy<zvkx>cydpb<ibdls>hs<jfv>hgg<kssv>p<lnjb>stsaz<o>w<dqjws>su<uli>yzqj<w>acr</w></uli></dqjws></o></lnjb></kssv></jfv></ibdls></zvkx></jlh></shte></txmsn></oq></gi></zcgdl></jjjmn>" "Valid"
test "<tq>ei<omobz>cvn<t>jeob<ull>a<jzmhc>deq<wqdm>vzoi<aj>bjy<rzw>td<piy>d<jpea>rwhe<ksxlc>rw<bmdb>easg<a>nz<ry>oei<zoeiv>ycm<i>gzk<hv>qaro<rr>tozpo</rr></hv></i></zoeiv></ry></a></bmdb></ksxlc></jpea></piy></rzw></aj></wqdm></jzmhc></ull></t></omobz></tq>" "Valid"
test "<rc>wv<rtcg>r<tsk>bhud<j>n<nnmx>rmndr<dwc>ok<v>h</v></dwc></nnmx></j></tsk></rtcg></rc>" "Valid"
test "<r>f<bbmqk>mt<ticg>eric<pnpcz>avj<m>pw<zcg>qlzb<syeyq>ru<nprsd>f</nprsd></syeyq></zcg></m></pnpcz></ticg></bbmqk></r>" "Valid"
test "lmlwst>g<h>qzxq>jf<hstu>nlebtc>as<enb>lsndu>ma<gqj>kst<hvfb>xvszqi>cr<hvrkoh>hvo<qj>gan<dgrhquc</d></qz></oh></h></szqi></hvhb></gqj></u></vnb></ebtc></hsku></xq></b></mlwst>" "Invalid"
test "<yf>swy<ob>hc<aj>gvh<odxj>im<qyaru>z<turg>q<jkoh>t<qt>j<tmt>cgvkj<ke>jum<um>j<pbc>ddl<xelh>dx<oo>shsea<ammuz>npg<bbskq>ckj<h>vp<xns>kio<f>t<hp>hbvw</hp></f></xns></h></bbskq></ammuz></oo></xelh></pbc></um></ke></tmt></qt></jkoh></turg></qyaru></odxj></aj></ob></yf>" "Valid"
test "<k>vbzuc<apn>sdor</apn></k>" "Valid"
test "<pv>zsibqv>rfuwm<jwkqa>lyuqxp>bflxmn>ngwqcx>n<iqwj>uwlap<omm>n<sgavdmhv<gsspmofz<ds>uoukjn>rxi<nwq>xdrfnslvkj>jflg<cjzqz>set<ywegxu<ea>fvy<lrhzkynbjt>hc</t></lr></ee></y></cjzqz></slvkj></ewq></n></js></gsspm></sgav></rmm></ipwj></x></mn></p></xwkqa></ibqv></pd>" "Invalid"
test "<szs>f<h>iwj</y></sgs>" "Invalid"
test "hkvtds>z<iamuc>vqknr</iamup></kvtds>" "Invalid"
test "<o>vh<ogy>hfo<mouk>d<uxa>l<u>rfxfo</u></uxa></mouk></ogy></o>" "Valid"
test "xoxhag>zbarpnd>glhrwdn>p<a>ps<nvsiafoezyu<gjcxu>qcdt<zheor>qsmj>dgbm<spej<ofhztljyfmu<yodrm<lvfjkatdxhm>ymvju<mtnc>mxxq<y>jr</q></manc></dxhm></lv></y></ofhzt></s></mj></zhexr></gjcuu></nvsia></l></hrwdn></rpnd></oxhag>" "Invalid"
test "<pxis>seiro<nap>kmit<oa>y<opn>aaya<y>b<de>brwzh<uwq>t<dvsjk>tcrlb<iv>gpus<mpdn>lhqb<os>zopk<e>pijc<qj>zge<rup>tavn<jxln>uzg<sco>dunm<hwmky>pkcej</hwmky></sco></jxln></rup></qj></e></os></mpdn></iv></dvsjk></uwq></de></y></opn></oa></nap></pxis>" "Valid"
test "<v>hoh<lmt>got<sdnzm>folvq<z>mchga<cyjml>ho<utw>gwd</utw></cyjml></z></sdnzm></lmt></v>" "Valid"
test "<twaf>bpev<zc>uteiwksys>jydjq>ev<nw>puka<xyj>jmyz</xyn></nx></jq></sys></zx></twhf>" "Invalid"
test "pkfoc>ciwxb<vsuqc>sbdbj<hueuhy<tbppfe<rn>wma<amkk>kv<zlw>zz<ocodn>yzxx</ocpdn></wlw></amkk></ro></tbpp></hue></vsuqa></kfoc>" "Invalid"
test "<hpd>oj<vivc>qujr<dx>oqcs<yqfp>h</yqfp></dx></vivc></hpd>" "Valid"
test "<nfbz<wiain>cw<dwchb>fzzznb>vth</nb></dwchd></yiain></n>" "Invalid"
test "<sppoe>qipas<k>rirmv<nllu>rbmy<syd>qwan<bs>xi<onx>qbzfq<wzs>lpxqy<f>eiio</f></wzs></onx></bs></syd></nllu></k></sppoe>" "Valid"
test "pepyo>zk<qwibej<zuc>c</guc></qw></epyo>" "Invalid"
test "kdwooo>r<omkjj>dbyr<bxh>cyo<fxo>bgulkd>w<wskj>qtdyw>mvkbm<daiimas<canq>qhvta<gncmk>ayyb<tzbtw>psf<okjbkt</ok></tzbtf></gndmk></cang></dai></dyw></wskj></d></fxn></bzh></gmkjj></dwooo>" "Invalid"
test "fo>qokyn<shrh>pgoxn<hkjetkzskl<shrk>rafv>wdgd>p<kjzljrmfc<u>nhyok<wga>yi<hy>a<viko>gk<vry>jucw<qrrhh>mr<vkfnl>w<gf>mutyf<ad>pqyp<iitrt>gllq</iitri></an></gb></tkfnl></qrdhh></vrd></viks></ky></wqa></m></kjz></d></v></shrk></hkje></syrh></o>" "Invalid"
test "<xbq>z<jt>rki<e>pn<pqzg>tojee<x>mpn<ht>cmjc<fzz>bfex<igo>hu<rsyn>ay<lt>k<hze>npwyd<cd>amlw<j>t<aw>dpmco</aw></j></cd></hze></lt></rsyn></igo></fzz></ht></x></pqzg></e></jt></xbq>" "Valid"
test "<qtffb>wpiov<u>ly<ez>g<q>ixcbr<b>h<r>vafp<opvn>ircsc<n>qlh<gdhu>nszv<gcsi>n<x>tnsa<xl>e<bk>ou<qb>d</qb></bk></xl></x></gcsi></gdhu></n></opvn></r></b></q></ez></u></qtffb>" "Valid"
test "<geu>t<hn>bgd<qje>zeltr</hje></qn></gxu>" "Invalid"
test "<jzd>fv<uw>hs<hikj>nnq<kjl>zlzq<qqlcz>fxgu<wvn>dqox<dfmrvg<qppz>cmubtifpk>q<awnrxak<cobhiewn<ofdvned<rikuaal<woyibybuwu<ssb>agcf<howj>kxvh<vcat>ngv<mltyl</ml></vcay></powj></lsb></woyib></r></ofd></cobh></awn></fpk></qpfz></d></wxn></qslcz></kcl></hxkj></hw></jgd>" "Invalid"
test "<ewt>jbz<pjkc>qnf<iizqs>pb<bdz>xardi<zbqb>jh</zbqb></bdz></iizqs></pjkc></ewt>" "Valid"
test "<ver>mmji<f>z<a>rsxr<cyrxd>it<dhjjb>datd<bwl>mcd<uveo>saje<nit>kbb<qavsr>yonuq<fdcu>g<n>zzkwm<zk>ff<p>tijg<msud>itmqn<qrzj>p<v>bozmm</v></qrzj></msud></p></zk></n></fdcu></qavsr></nit></uveo></bwl></dhjjb></cyrxd></a></f></ver>" "Valid"
test "<yfxn>n<w>ujsfb<okcbc>qa<jleur>t<f>al<w>xuotk<n>xz</n></w></f></jleur></okcbc></w></yfxn>" "Valid"
test "ox>c<u>nlbg<zhjoxpycr<a>wdx</t></zhjo></j></x>" "Invalid"
test "<fjrx>hrv<lxmm>ht</lxxm></fyrx>" "Invalid"
test "<dbi>hkutw<lmzu>abblh<u>jmw<aczb>hfkaa<lckwt>q<ra>upd<kn>ofat<bvubq>fgs<o>tr<dgtt>gob<blifq>e<bl>ggtd<s>x<lp>q<kg>jyxq<kg>tnedy<wckux>zn<lss>yrzk<kotb>efq</kotb></lss></wckux></kg></kg></lp></s></bl></blifq></dgtt></o></bvubq></kn></ra></lckwt></aczb></u></lmzu></dbi>" "Valid"
test "<cvmrhs<viqil>m<lpkhm>w<oh>j<fhd>khvptp>lhqt<jd>gl<nuwxdgjvwgq>rfbh</jvwgq></nu></jm></ptp></fzd></oz></lpkhk></fiqil></cv>" "Invalid"
test "<nuq>sukyc<uamx>crqqs</uamt></nui>" "Invalid"
test "<czwwbufmo<acffy>immid<sqayyalme</sqayy></acfdy></czww>" "Invalid"
test "<jwjzkkaq<fn>fpzgsyy>svryee>lo<deyljr<ntcdeylpr<vk>hwrsjyhxcd>e<lyxvqjrt<id>bp<dkjl>v<rz>hw<s>bhzkmnlyaj>yf<xwbjwy<twdp</t></xwb></lyaj></f></rm></dkjm></ix></lyx></yhxcd></vt></ntc></de></e></y></fg></jwj>" "Invalid"
test "<wy>xke<rq>m<xug>exzxb<l>gn<egh>ace<pho>a<fee>jtmsq<hfbpl>kjyg<apav>tu<lwxo>anm<anwl>j<e>a<htha>zvxj<djfbm>xft<zn>sif<d>atd<evv>bmfnc<vbnca>mtl<k>dbcs<orjg>oz</orjg></k></vbnca></evv></d></zn></djfbm></htha></e></anwl></lwxo></apav></hfbpl></fee></pho></egh></l></xug></rq></wy>" "Valid"
test "<drcm>yiq<yjke>i<ufb>rnnrr<wlq>xqe<thvu>itch<inyuy>pgwsg</inyuy></thvu></wlq></ufb></yjke></drcm>" "Valid"
test "<gcxe>ifmu<wjki>wcgj<vxak>tsdkv<ei>lpsv<s>wdek<zr>bjqb<v>zuj<yilfe>gw</yilfe></v></zr></s></ei></vxak></wjki></gcxe>" "Valid"
test "<ukh>ldfey<azwtx>pa<hg>sbyb<t>som<pqjs>wxdgd<vdp>vbhd<rb>pu<riud>ook<zjdkb>vra<xvayx>meaj</xvayx></zjdkb></riud></rb></vdp></pqjs></t></hg></azwtx></ukh>" "Valid"
test "<web>wkqdq<az>ynvxz<wtt>lw<npch>lbqdm<om>lvuj</om></npch></wtt></az></web>" "Valid"
test "<wya>dw<wjl>otw<zdtf>fquph<w>hndq<ybbg>hgnbs<giuk>bi<flhh>fzdf<egww>xs<grr>sgh</grr></egww></flhh></giuk></ybbg></w></zdtf></wjl></wya>" "Valid"
test "<kwjgzw>rjuy<mk>c<pybbrip<lnqw>pkjad<f>epfs>zbozj<jylc<mcwd>qhydq<ayk>ueba<fhtjhp<aemh>pbog<gqddzbmyxp<e>a<ut>zea<bo>dxqbe<uhu>iwa<zesl>rcat<ccog>aaj</ccog></zess></vhu></ao></ul></d></gqddz></aemw></fht></ajk></mcws></jy></s></m></lnqr></pybbr></sk></w></k>" "Invalid"
test "<skb>chn<tyhl>peq<qbkr>bs<ad>n<vtwh>rt<chbd<pydh>fc<inmcz>xx<ydjp>gzqk</yhjp></inbcz></iydh></c></vkwh></xd></qpkr></qyhl></sdb>" "Invalid"
test "<k>aet</k>" "Valid"
test "<p>l<bsine>unbwl>v</wl></bsiie></f>" "Invalid"
test "<ko>ytxsh<we>iniyb<rrjw>v<fzcxh>m<rx>blgl<p>nm<dvfm>udzcw<v>qw<ijuzz>meuea<movsg>gkgj<rvmkr>gabnk<yjw>vc<cxob>gqjos</cxob></yjw></rvmkr></movsg></ijuzz></v></dvfm></p></rx></fzcxh></rrjw></we></ko>" "Valid"
test "<jatfk>e<ux>ee<lrv>rth<lkprl>vwq</lkprl></lrv></ux></jatfk>" "Valid"
test "<dm>gu<z>xii<nahbx>c<sd>w<lh>w<wje>a<imch>thd<yyl>exn<kc>dfwst<dvy>bd<emnmk>mqmg<eoedh>h</eoedh></emnmk></dvy></kc></yyl></imch></wje></lh></sd></nahbx></z></dm>" "Valid"
test "<ubieq<wlrqc>rci<snbmg>kvfzrg>qwmohpl>yugco<xespqjj<lowg>w<uojto>yaio<keoo>wjbjo</kboo></uoeto></lofg></x></pl></fzrg></snnmg></wlrqc></u>" "Invalid"
test "<sld>nloq<iwip>ofe<lpfk>pwsgo<ii>qa<legu>pjcp<wm>phq<qbr>pmp<uz>e<bht>ywrf<metrv>knotj<z>qgvw<tb>h<apgy>zl<h>svis<mp>lysm<ahc>fymkh<b>g<dwily>y</dwily></b></ahc></mp></h></apgy></tb></z></metrv></bht></uz></qbr></wm></legu></ii></lpfk></iwip></sld>" "Valid"
test "<e>eupoh<uol>fsz<mitsh>yxoxw<p>cc<j>dqf<xpyrf>nzv<i>sgkiq<obp>ttjty<btlof>lws<niot>v<aglyz>s<p>ehwcy<vjca>y<mh>kwvr</mh></vjca></p></aglyz></niot></btlof></obp></i></xpyrf></j></p></mitsh></uol></e>" "Valid"
test "<af>sjohp<gdgmyloa>fninq<xzeic>uoov<guly<dkoaajjwxq<jvl>pdbqy<xpqdi>vuftxaa>gp</aa></fpqdi></jpl></dkoaa></g></azeic></a></gdg></ai>" "Invalid"
test "rofhpu>bruyt<zfn>wz<rgvpyenf<maegb<dpsrr<aspt>tk<aujtz>fzh<yzqhdi<lpyaj<isge>k<wlumj>quaw<kag>su<tm>crbab<a>swq<twdq>lsajc>avy>tnd<fgrfl>xxbwxlxe>sth</lxe></fgrfw></y></jc></tweq></j></pm></kay></wluvj></fsge></l></y></auqtz></abpt></d></m></rg></zfn></ofhpu>" "Invalid"
test "<mkh>chh<bhhi>r</bhhi></mkh>" "Valid"
test "vcxod>hml<wxx>hhrd<k>w<a>agfpkr>hxooh</kr></h></r></wxq></cxod>" "Invalid"
test "<joeys>tiy<iwojs>t<gkyfy>u<ngngt>svdxe<hpwwk>mtvgk<fpsbk>ikjgo<bsb>k</bsb></fpsbk></hpwwk></ngngt></gkyfy></iwojs></joeys>" "Valid"
test "ifywlz>x<ebipz>smtiaopj>trrfu<zvby>lbzea<pokl>zkqx<kbfg<yqdn<iyf<hy>urp<ykoe>ageqq<uj>dblqgikdd>ytyr<rpu>tayvto>d<odirx>xxv<scr>jrig<ou>zufs<vum>jon<louu>wy</loyu></vmm></ju></ocr></odidx></o></ryu></gikdd></uf></ykoo></he></i></yq></kb></pokl></zviy></pj></ebiez></fywlz>" "Invalid"
test "<pf>ciiry<vd>bs<fteuh>y<pnr>fda<wfsj>v<zbyd>oh<jrez>hgrf<urqhf>rg<ayrgg>syzu<w>ddhth<lt>honq<jbm>ee<joh>jk<fb>gb<qahx>i<jnt>osjfs</jnt></qahx></fb></joh></jbm></lt></w></ayrgg></urqhf></jrez></zbyd></wfsj></pnr></fteuh></vd></pf>" "Valid"
test "<ceti>uw<ybeeg>wb<aftbwj<bzfiovkm<sqwgzyidukkpz>pbmk<hmx>igjn>a<j>rj</f></jn></hms></kpz></sqw></bz></a></qbeeg></cefi>" "Invalid"
test "<qpamd>pjkor<nmg>rd<xtbeq>vst<m>v<lkeju>t<iglpt>nifkz<ty>s<xxhvw>vzagc<t>rhynf<r>b<guyi>il<aymh>dim<johw>l<mxpd>uqkr<au>xrotw<lsr>qii<vqp>uy<g>aopwo<gx>wsgd</gx></g></vqp></lsr></au></mxpd></johw></aymh></guyi></r></t></xxhvw></ty></iglpt></lkeju></m></xtbeq></nmg></qpamd>" "Valid"
test "<in>cdja<hswma>jzyqf</hswmf></vn>" "Invalid"
test "<zrhsg>uzwmg<gw>xiwm<ky>xlcp<payn>t<e>gyrym<by>ewa<zohi>vg<efxk>trmz<tle>ddbv<dz>zjs<vcsy>vos<dbpzp>k<emv>u<tllx>yyfbe<lb>whmka<mc>l</mc></lb></tllx></emv></dbpzp></vcsy></dz></tle></efxk></zohi></by></e></payn></ky></gw></zrhsg>" "Valid"
test "<erfcu>ocdylqhp>qmbo<njughs<bto<cye>z<qjrwmpts<nvtp>nlward>lpyq<vvwox>y<ciiut>morgk<qbwldwktwx>tdwty<cdjtb>mc<vwwqa>j<aamd>gll</pamd></vwwka></cgjtb></x></qbwld></ciiuq></vvwov></rd></nutp></qjrwm></cyk></b></nju></hp></wrfcu>" "Invalid"
test "<h>ruqv<atl>x<jin>rm<zkke>hdbe<v>dijje<yob>j<egu>kg<tmok>fnu<osix>psbr<ctmf>csh<h>l<fdx>sae<bwf>qk<o>pww<kltv>gp<sbl>alu<uilmv>mbexh<qxkis>uhcq<obuvh>n</obuvh></qxkis></uilmv></sbl></kltv></o></bwf></fdx></h></ctmf></osix></tmok></egu></yob></v></zkke></jin></atl></h>" "Valid"
test "<vgi>qva<imm>rfrnt<nxfx>y<uk>iq<n>vfle<zz>qny<l>ufaj<klnf>pf<in>ekimc<q>bixhp<ixlo>v<ohii>yqhx<gkgom>bnse<ebn>veg<f>woe</f></ebn></gkgom></ohii></ixlo></q></in></klnf></l></zz></n></uk></nxfx></imm></vgi>" "Valid"
test "<omrug>q<kwjk<hru>omj<thbvqbfwtu<wunrkqj<svso>gc<nynml>eiigv<mbfdb>i<ozw>dsa<lbu>ych</lcu></ozc></mbidb></nynxl></qvso></w></thbvq></heu></k></omrfg>" "Invalid"
test "<drha>ke<m>j<qnquu>tmmx<sgje>bq<rvph>cb<n>g<uxiro>fl</uxiro></n></rvph></sgje></qnquu></m></drha>" "Valid"
test "<zksu>lyghz<uz>pmgw<l>wdbl<hrjt>qfeo</hrjt></l></uz></zksu>" "Valid"
test "<wlyut>hfw<buotdkrtdgl>k<xhl<rkmo>pmi<zgpywevb<vew>wrtcn<sv>zqwv>gqrc>pgqp<byev>vkviypti>iojdl<w>plpx<gal>wovivto>qwpw<iuaxurlb<cc>sqqbhyd>buj<sdaff>sshy</sdafl></yd></cy></iu></ivto></gzl></e></pti></byek></rc></wv></sv></vow></zgp></rkmo></x></tdgl></b></wliut>" "Invalid"
test "<psio>zadcs<jos>ktmq<fa>mlt<bhkuy>eume<h>tlp<ix>vm<idsv>hxbqj<lefm>ky</lefm></idsv></ix></h></bhkuy></fa></jos></psio>" "Valid"
test "<rznno>imh<ce>bxf<ti>fcwty<m>r<ddxe>r<kddl>ibosr<d>lffk</d></kddl></ddxe></m></ti></ce></rznno>" "Valid"
test "<q>dxpzq<fduxb>bzazl<bomht>ae<jdh>syghh<wg>dxm<qua>wyq<tctyn>d<oe>juau</oe></tctyn></qua></wg></jdh></bomht></fduxb></q>" "Valid"
test "<pwokvuovi>revjy<ofxmyk<ydzj<qiukt>szkox>webh<szgilflv<dmijw>tjntgqpus>mz<xv>g</xz></pus></rmijw></sz></x></qiukv></yd></ofxm></vi></p>" "Invalid"
test "<tf>vk<e>ob<snu>tvhq<rozfbi<qfo>s<ad>dzty>blmwd<looqtft<gdxp>omi<pb>zhgsi<ouinw>isco<yg>ws<iuzf<isu>fzro<hropfjjb<dl>fepak>jxiq<nzjqg>esxka<f>v</f></nzjqm></ak></al></hro></gsu></i></vg></ozinw></py></pdxp></l></y></ac></qfb></roz></swu></q></cf>" "Invalid"
test "<euk>su<qgikf>pxd<n>j<eqqh>ainx</eqqh></n></qgikf></euk>" "Valid"
test "<cgowba</cg>" "Invalid"
test "<vyaki>finn<chx>uch<xhdptt<fod>gaf</fsd></xh></cex></vyako>" "Invalid"
test "yakskn>mz<koq>tmkfs<hxj>k<hddbp>jna>mbp<osq>akdvnsh>vrha<tyk>eh</tpk></dvnsh></obq></a></htdbp></hkj></loq></akskn>" "Invalid"
test "<udote>z<me>ybfoh<nxeky>yac<umwn>ngl<lps>qu</lps></umwn></nxeky></me></udote>" "Valid"
test "<mrodq>tp<osp>hiexw<queo>ilok<o>ndcv<ew>kaf<atg>vm<xqa>tzmb<rbkyd>zbvn<zdcr>jzon<yhig>iu<mxx>dhh<ep>qfvov<okyl>yve<lxw>rpu<td>loi<iyin>bqjkn<ti>m<dorjr>yehx</dorjr></ti></iyin></td></lxw></okyl></ep></mxx></yhig></zdcr></rbkyd></xqa></atg></ew></o></queo></osp></mrodq>" "Valid"
test "<jw>bagk<ulkbh>cpkil</elkbh></jw>" "Invalid"
test "<mfd>hkxueluvxx>dka<yqneo>dx<qffgy>hwpe<cga>q<dhzlq>l<af>semoruw>ktiya<trj>isct<ckhd>xalmn<m>smrlv>ty</v></h></ckhl></tnj></uw></mf></dhglq></csa></qffgn></qqneo></uvxx></mff>" "Invalid"
test "<e>hjtw<pol>xauqb<j>d<a>wj<fltx>cmjb<qifm>j<xdx>asnzm<zjai>aceg<iml>m<guzgv>smkgo<rzpe>bwkho<asx>hgx</asx></rzpe></guzgv></iml></zjai></xdx></qifm></fltx></a></j></pol></e>" "Valid"
test "<rgf>dh<slumrrdqomtub>gs</mtub></slum></rif>" "Invalid"
test "<uh>ggkh</uh>" "Valid"
test "bjmpt>cepcc<hghi>zaaic<kp>m<okgez>rf<chcpgfqyi>pk<ywsf<oncjf>juyhlo>m<tcbjjgrj<bmqdx>wtqos</bmgdx></tcbjj></lo></oscjf></y></qyi></chc></okgqz></yp></hghl></jmpt>" "Invalid"
test "<fqhgx>vezdl<pm>ai<fmbuz>gjfw<d>qgwmn<pna>i<pk>m<uoad>iniu<eprko>tzfow<nic>y<x>ho<oq>iwmhj<nxkpz>ueyvl<zkw>fqwrs</zkw></nxkpz></oq></x></nic></eprko></uoad></pk></pna></d></fmbuz></pm></fqhgx>" "Valid"
test "<w>gxdwv<r>sdrkj<cwwfq>ihfn<hy>pj<wlc>chwmz<z>lkhq<oybd>ijyxs<kdbnw>qmkju<ji>r</ji></kdbnw></oybd></z></wlc></hy></cwwfq></r></w>" "Valid"
test "<xclqs>but<o>fwjtq<sok>ejc<e>bi<dr>lvom<xg>bt<kt>ljkdv<i>d<sp>lklg</sp></i></kt></xg></dr></e></sok></o></xclqs>" "Valid"
test "fnm>uoaxejy>meqftskq>na<ubdkqqscm>h<tvbqqzlpp>exn<tuqe>lvfp<vjrbm>ayjqnexob>ik<d>nsnugmuh>aveba>k<ppsar>tljofuewm>xe<welhf>hptdpbjbp>jpfuy<vv>je</gv></jbp></welhe></fuewm></ppslr></ba></ugmuh></x></nexob></vdrbm></tuqv></p></t></m></ubdk></ftskq></jy></nm>" "Invalid"
test "<e>kxxwb<uzxul>lla<yaukj>dthf<qscxi>mcv<fm>kavw<ktc>z<orgxo>qkeg<twu>of<wwzfh>xs<wv>vl<evh>in<pdbu>av<z>yv<w>b<un>qrqtp<z>exim<jawsq>ugh<qwcnc>pxnaz<uwy>g<ppdv>fhi</ppdv></uwy></qwcnc></jawsq></z></un></w></z></pdbu></evh></wv></wwzfh></twu></orgxo></ktc></fm></qscxi></yaukj></uzxul></e>" "Valid"
test "<zxozd>ngy</zxodd>" "Invalid"
test "zezi>gz<rpqe>ldf<zhesk>b<ufhkd<svnjbgytwh<dpicidx<kbsc>halj<mdf>bnqx<uwf>pjx<vgnn<dl>yjxh<gcy<nfvjw>pzrvt>up<zose>wn<vwgru<tnv>se<yxj</y></inv></v></zome></vt></nfvjc></g></cl></vg></iwf></edf></cbsc></dpic></svnjb></u></zmesk></riqe></ezi>" "Invalid"
test "<nd>e</nd>" "Valid"
test "<ynky>hsvzr<b>isr<fdgsd>luiu<paxvi>o<iwnwk>cut<l>h<ngmq>zabl<bhfxt>scqtk<to>ep<ttscm>jp<nosz>yc<gr>pubsa<igxn>rmjz<bcwc>hw<e>i<jc>nyh</jc></e></bcwc></igxn></gr></nosz></ttscm></to></bhfxt></ngmq></l></iwnwk></paxvi></fdgsd></b></ynky>" "Valid"
test "<cc>vbwth<vcubq>by<dy>bifdx<sjvu>xznj<pc>bxjtq<o>gdsva<ik>uni<lku>nols<laz>qcs<g>i<fpyid>mzrp<f>pm<vro>u<gc>e</gc></vro></f></fpyid></g></laz></lku></ik></o></pc></sjvu></dy></vcubq></cc>" "Valid"
test "<ws>d<dvq>aibex<swx>lginw<zwhln>uuxmc<mkviabsgo<u>yil<nvo>fpe<dus>advn<th>wtuv<lzq>k<ahfvrurs<btqm>ztphjd>ge<dwdun>wcav<fshks>ks<pgwee>r<zbnh>gawldvyb>vtdl<dkqb>da</doqb></yb></zunh></pvwee></fshki></dydun></phjd></mtqm></ah></uzq></tx></gus></nvn></i></mkv></zweln></rwx></dva></wd>" "Invalid"
test "<yx>vspy<vg>ohstq<pwq>ltj<iavfe>ah<vx>f<cd>rsibl<rhnh>kj<ne>cw<ay>yny<h>ogf<napp>pzhr<gd>aqmh<vs>gibm<rcdhy>wxqu<e>p<wp>hlbmu</wp></e></rcdhy></vs></gd></napp></h></ay></ne></rhnh></cd></vx></iavfe></pwq></vg></yx>" "Valid"
test "hdz>sloh<jhr>ufd<tcim>vxiamlxxr>rxwsesy>ly<qhn>df<hfes<oten>qn<ngwdt<occ>ctjss<rjahw>tadgd<hcal>zq</hkal></rjahb></ocb></n></otej></h></qhr></y></lxxr></tcwm></yhr></dz>" "Invalid"


echo "Test ${test_count:-0}: ${pass_count:-0} PASS, ${fail_count:-0} FAIL"
echo "Test script exit successfully"