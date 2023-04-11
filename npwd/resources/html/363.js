/*! For license information please see 363.js.LICENSE.txt */
(self.webpackChunknpwd_nui=self.webpackChunknpwd_nui||[]).push([[363,5251],{50594:function(e,t,n){"use strict";var r=n(64119);t.Z=void 0;var o=r(n(64938)),a=n(85893),i=(0,o.default)((0,a.jsx)("path",{d:"M19 6.41 17.59 5 12 10.59 6.41 5 5 6.41 10.59 12 5 17.59 6.41 19 12 13.41 17.59 19 19 17.59 13.41 12z"}),"Close");t.Z=i},62665:function(e,t,n){"use strict";var r=n(64119);t.Z=void 0;var o=r(n(64938)),a=n(85893),i=(0,o.default)((0,a.jsx)("path",{d:"M5 4v2h14V4H5zm0 10h4v6h6v-6h4l-7-7-7 7z"}),"Publish");t.Z=i},42761:function(e,t,n){"use strict";var r=n(64119);t.Z=void 0;var o=r(n(64938)),a=n(85893),i=(0,o.default)((0,a.jsx)("path",{d:"M15.5 14h-.79l-.28-.27C15.41 12.59 16 11.11 16 9.5 16 5.91 13.09 3 9.5 3S3 5.91 3 9.5 5.91 16 9.5 16c1.61 0 3.09-.59 4.23-1.57l.27.28v.79l5 4.99L20.49 19l-4.99-5zm-6 0C7.01 14 5 11.99 5 9.5S7.01 5 9.5 5 14 7.01 14 9.5 11.99 14 9.5 14z"}),"Search");t.Z=i},64119:function(e){e.exports=function(e){return e&&e.__esModule?e:{default:e}},e.exports.__esModule=!0,e.exports.default=e.exports},64938:function(e,t,n){"use strict";Object.defineProperty(t,"__esModule",{value:!0}),Object.defineProperty(t,"default",{enumerable:!0,get:function(){return r.createSvgIcon}});var r=n(64298)},98363:function(e,t,n){"use strict";const r=n(92950).createContext({});t.Z=r},69397:function(e,t,n){"use strict";var r=n(1048),o=n(32793),a=n(92950),i=n(86010),l=n(47925),c=n(27192),u=n(94581),s=n(58524),d=n(71657),p=n(35640),f=n(98216),v=n(97933),b=n(98363),h=n(85893);const y=["children","color","component","className","disabled","disableElevation","disableFocusRipple","endIcon","focusVisibleClassName","fullWidth","size","startIcon","type","variant"],g=e=>(0,o.Z)({},"small"===e.size&&{"& > *:nth-of-type(1)":{fontSize:18}},"medium"===e.size&&{"& > *:nth-of-type(1)":{fontSize:20}},"large"===e.size&&{"& > *:nth-of-type(1)":{fontSize:22}}),m=(0,s.ZP)(p.Z,{shouldForwardProp:e=>(0,s.FO)(e)||"classes"===e,name:"MuiButton",slot:"Root",overridesResolver:(e,t)=>{const{ownerState:n}=e;return[t.root,t[n.variant],t[`${n.variant}${(0,f.Z)(n.color)}`],t[`size${(0,f.Z)(n.size)}`],t[`${n.variant}Size${(0,f.Z)(n.size)}`],"inherit"===n.color&&t.colorInherit,n.disableElevation&&t.disableElevation,n.fullWidth&&t.fullWidth]}})((({theme:e,ownerState:t})=>(0,o.Z)({},e.typography.button,{minWidth:64,padding:"6px 16px",borderRadius:e.shape.borderRadius,transition:e.transitions.create(["background-color","box-shadow","border-color","color"],{duration:e.transitions.duration.short}),"&:hover":(0,o.Z)({textDecoration:"none",backgroundColor:(0,u.Fq)(e.palette.text.primary,e.palette.action.hoverOpacity),"@media (hover: none)":{backgroundColor:"transparent"}},"text"===t.variant&&"inherit"!==t.color&&{backgroundColor:(0,u.Fq)(e.palette[t.color].main,e.palette.action.hoverOpacity),"@media (hover: none)":{backgroundColor:"transparent"}},"outlined"===t.variant&&"inherit"!==t.color&&{border:`1px solid ${e.palette[t.color].main}`,backgroundColor:(0,u.Fq)(e.palette[t.color].main,e.palette.action.hoverOpacity),"@media (hover: none)":{backgroundColor:"transparent"}},"contained"===t.variant&&{backgroundColor:e.palette.grey.A100,boxShadow:e.shadows[4],"@media (hover: none)":{boxShadow:e.shadows[2],backgroundColor:e.palette.grey[300]}},"contained"===t.variant&&"inherit"!==t.color&&{backgroundColor:e.palette[t.color].dark,"@media (hover: none)":{backgroundColor:e.palette[t.color].main}}),"&:active":(0,o.Z)({},"contained"===t.variant&&{boxShadow:e.shadows[8]}),[`&.${v.Z.focusVisible}`]:(0,o.Z)({},"contained"===t.variant&&{boxShadow:e.shadows[6]}),[`&.${v.Z.disabled}`]:(0,o.Z)({color:e.palette.action.disabled},"outlined"===t.variant&&{border:`1px solid ${e.palette.action.disabledBackground}`},"outlined"===t.variant&&"secondary"===t.color&&{border:`1px solid ${e.palette.action.disabled}`},"contained"===t.variant&&{color:e.palette.action.disabled,boxShadow:e.shadows[0],backgroundColor:e.palette.action.disabledBackground})},"text"===t.variant&&{padding:"6px 8px"},"text"===t.variant&&"inherit"!==t.color&&{color:e.palette[t.color].main},"outlined"===t.variant&&{padding:"5px 15px",border:"1px solid "+("light"===e.palette.mode?"rgba(0, 0, 0, 0.23)":"rgba(255, 255, 255, 0.23)")},"outlined"===t.variant&&"inherit"!==t.color&&{color:e.palette[t.color].main,border:`1px solid ${(0,u.Fq)(e.palette[t.color].main,.5)}`},"contained"===t.variant&&{color:e.palette.getContrastText(e.palette.grey[300]),backgroundColor:e.palette.grey[300],boxShadow:e.shadows[2]},"contained"===t.variant&&"inherit"!==t.color&&{color:e.palette[t.color].contrastText,backgroundColor:e.palette[t.color].main},"inherit"===t.color&&{color:"inherit",borderColor:"currentColor"},"small"===t.size&&"text"===t.variant&&{padding:"4px 5px",fontSize:e.typography.pxToRem(13)},"large"===t.size&&"text"===t.variant&&{padding:"8px 11px",fontSize:e.typography.pxToRem(15)},"small"===t.size&&"outlined"===t.variant&&{padding:"3px 9px",fontSize:e.typography.pxToRem(13)},"large"===t.size&&"outlined"===t.variant&&{padding:"7px 21px",fontSize:e.typography.pxToRem(15)},"small"===t.size&&"contained"===t.variant&&{padding:"4px 10px",fontSize:e.typography.pxToRem(13)},"large"===t.size&&"contained"===t.variant&&{padding:"8px 22px",fontSize:e.typography.pxToRem(15)},t.fullWidth&&{width:"100%"})),(({ownerState:e})=>e.disableElevation&&{boxShadow:"none","&:hover":{boxShadow:"none"},[`&.${v.Z.focusVisible}`]:{boxShadow:"none"},"&:active":{boxShadow:"none"},[`&.${v.Z.disabled}`]:{boxShadow:"none"}})),x=(0,s.ZP)("span",{name:"MuiButton",slot:"StartIcon",overridesResolver:(e,t)=>{const{ownerState:n}=e;return[t.startIcon,t[`iconSize${(0,f.Z)(n.size)}`]]}})((({ownerState:e})=>(0,o.Z)({display:"inherit",marginRight:8,marginLeft:-4},"small"===e.size&&{marginLeft:-2},g(e)))),O=(0,s.ZP)("span",{name:"MuiButton",slot:"EndIcon",overridesResolver:(e,t)=>{const{ownerState:n}=e;return[t.endIcon,t[`iconSize${(0,f.Z)(n.size)}`]]}})((({ownerState:e})=>(0,o.Z)({display:"inherit",marginRight:-4,marginLeft:8},"small"===e.size&&{marginRight:-2},g(e)))),S=a.forwardRef((function(e,t){const n=a.useContext(b.Z),u=(0,l.Z)(n,e),s=(0,d.Z)({props:u,name:"MuiButton"}),{children:p,color:g="primary",component:S="button",className:j,disabled:w=!1,disableElevation:P=!1,disableFocusRipple:k=!1,endIcon:C,focusVisibleClassName:I,fullWidth:z=!1,size:Z="medium",startIcon:T,type:N,variant:E="text"}=s,_=(0,r.Z)(s,y),R=(0,o.Z)({},s,{color:g,component:S,disabled:w,disableElevation:P,disableFocusRipple:k,fullWidth:z,size:Z,type:N,variant:E}),B=(e=>{const{color:t,disableElevation:n,fullWidth:r,size:a,variant:i,classes:l}=e,u={root:["root",i,`${i}${(0,f.Z)(t)}`,`size${(0,f.Z)(a)}`,`${i}Size${(0,f.Z)(a)}`,"inherit"===t&&"colorInherit",n&&"disableElevation",r&&"fullWidth"],label:["label"],startIcon:["startIcon",`iconSize${(0,f.Z)(a)}`],endIcon:["endIcon",`iconSize${(0,f.Z)(a)}`]},s=(0,c.Z)(u,v.F,l);return(0,o.Z)({},l,s)})(R),M=T&&(0,h.jsx)(x,{className:B.startIcon,ownerState:R,children:T}),F=C&&(0,h.jsx)(O,{className:B.endIcon,ownerState:R,children:C});return(0,h.jsxs)(m,(0,o.Z)({ownerState:R,className:(0,i.Z)(j,n.className),component:S,disabled:w,focusRipple:!k,focusVisibleClassName:(0,i.Z)(B.focusVisible,I),ref:t,type:N},_,{classes:B,children:[M,p,F]}))}));t.Z=S},97933:function(e,t,n){"use strict";n.d(t,{F:function(){return o}});var r=n(28979);function o(e){return(0,r.Z)("MuiButton",e)}const a=(0,n(76087).Z)("MuiButton",["root","text","textInherit","textPrimary","textSecondary","outlined","outlinedInherit","outlinedPrimary","outlinedSecondary","contained","containedInherit","containedPrimary","containedSecondary","disableElevation","focusVisible","disabled","colorInherit","textSizeSmall","textSizeMedium","textSizeLarge","outlinedSizeSmall","outlinedSizeMedium","outlinedSizeLarge","containedSizeSmall","containedSizeMedium","containedSizeLarge","sizeMedium","sizeSmall","sizeLarge","fullWidth","startIcon","endIcon","iconSizeSmall","iconSizeMedium","iconSizeLarge"]);t.Z=a},75251:function(e,t,n){"use strict";n(27418);var r=n(92950),o=60103;if(t.Fragment=60107,"function"==typeof Symbol&&Symbol.for){var a=Symbol.for;o=a("react.element"),t.Fragment=a("react.fragment")}var i=r.__SECRET_INTERNALS_DO_NOT_USE_OR_YOU_WILL_BE_FIRED.ReactCurrentOwner,l=Object.prototype.hasOwnProperty,c={key:!0,ref:!0,__self:!0,__source:!0};function u(e,t,n){var r,a={},u=null,s=null;for(r in void 0!==n&&(u=""+n),void 0!==t.key&&(u=""+t.key),void 0!==t.ref&&(s=t.ref),t)l.call(t,r)&&!c.hasOwnProperty(r)&&(a[r]=t[r]);if(e&&e.defaultProps)for(r in t=e.defaultProps)void 0===a[r]&&(a[r]=t[r]);return{$$typeof:o,type:e,key:u,ref:s,props:a,_owner:i.current}}t.jsx=u,t.jsxs=u},77094:function(e,t,n){"use strict";n.d(t,{rV:function(){return a}});var r=n(97444),o=n(97435),a=function(){return(0,r.useRecoilState)(o.K)}},62374:function(e,t,n){"use strict";n.d(t,{S:function(){return a}});var r=new(n(71950).Validator);r.addSchema({id:"/IconSetValue",type:"object",properties:{name:{type:"string"},custom:{type:"boolean"}},required:!0},"/IconSetValue"),r.addSchema({id:"/SettingOptionIconSet",type:"object",properties:{label:{type:"string"},value:{$ref:"/IconSetValue"}},required:!0},"/SettingOptionIconSet");var o={type:"object",properties:{callVolume:{type:"number",required:!0},iconSet:{$ref:"/SettingOptionIconSet",required:!0},language:{$ref:"/SettingOption",required:!0},wallpaper:{$ref:"/SettingOption",required:!0},frame:{$ref:"/SettingOption",required:!0},theme:{$ref:"/SettingOption",required:!0},zoom:{$ref:"/SettingOption",required:!0},streamerMode:{type:"boolean",required:!0},ringtone:{$ref:"/SettingOption",required:!0},notiSound:{$ref:"/SettingOption",required:!0},TWITTER_notiFilter:{$ref:"/SettingOption",required:!0},TWITTER_notiSound:{$ref:"/SettingOption",required:!0},TWITTER_notiSoundVol:{type:"number",required:!0},TWITTER_notifyNewFeedTweet:{type:"boolean",required:!0},MARKETPLACE_notifyNewListing:{type:"boolean",required:!0}}};function a(e){var t=JSON.parse(e);return r.validate(t,o).valid}r.addSchema({id:"/SettingOption",type:"object",properties:{label:{type:"string"},val:{type:"string"}},required:!0},"/SettingOption")},76587:function(e,t,n){"use strict";n.d(t,{b:function(){return s}});var r=n(85893),o=n(92950),a=n(42588),i=n(37182),l=n(91831),c=function(){return c=Object.assign||function(e){for(var t,n=1,r=arguments.length;n<r;n++)for(var o in t=arguments[n])Object.prototype.hasOwnProperty.call(t,o)&&(e[o]=t[o]);return e},c.apply(this,arguments)},u=(0,l.Z)({root:{zIndex:1e4},msg:{maxWidth:"300px",wordWrap:"break-word",fontSize:"1.1em"}}),s=(0,o.forwardRef)((function(e,t){var n=u();return(0,r.jsx)(a.Z,c({className:n.root,elevation:4,variant:"filled"},e,{ref:t},{children:(0,r.jsx)(i.Typography,c({className:n.msg},{children:e.children}),void 0)}),void 0)}))},61103:function(e,t,n){"use strict";n.d(t,{L:function(){return d}});var r=n(85893),o=n(92950),a=n.n(o),i=n(37182),l=n(91831),c=n(39519),u=function(){return u=Object.assign||function(e){for(var t,n=1,r=arguments.length;n<r;n++)for(var o in t=arguments[n])Object.prototype.hasOwnProperty.call(t,o)&&(e[o]=t[o]);return e},u.apply(this,arguments)},s=(0,l.Z)((function(){return{wrapper:{flex:1,flexDirection:"column",display:"flex"},backdrop:{position:"absolute",zIndex:1},paper:{width:"100%",flex:"1 1 auto"}}})),d=function(e){var t=e.children,n=e.paperStyle,o=e.backdrop,l=e.disableSuspenseHandler,d=e.onClickBackdrop,p=function(e,t){var n={};for(var r in e)Object.prototype.hasOwnProperty.call(e,r)&&t.indexOf(r)<0&&(n[r]=e[r]);if(null!=e&&"function"==typeof Object.getOwnPropertySymbols){var o=0;for(r=Object.getOwnPropertySymbols(e);o<r.length;o++)t.indexOf(r[o])<0&&Object.prototype.propertyIsEnumerable.call(e,r[o])&&(n[r[o]]=e[r[o]])}return n}(e,["children","paperStyle","backdrop","disableSuspenseHandler","onClickBackdrop"]),f=s();return(0,r.jsxs)(i.Paper,u({className:f.wrapper,square:!0,style:o?{overflow:"hidden"}:{overflow:"auto"}},{children:[(0,r.jsx)(i.Backdrop,{className:f.backdrop,open:o||!1,onClick:d},void 0),(0,r.jsx)(i.Paper,u({sx:{flexGrow:1},square:!0,elevation:0,className:"".concat(f.paper," ").concat(p.className),style:n},{children:l?{children:t}:(0,r.jsx)(a().Suspense,u({fallback:(0,r.jsx)(c.T,{},void 0)},{children:t}),void 0)}),void 0)]}),void 0)}},59789:function(e,t,n){"use strict";n.d(t,{y:function(){return p}});var r=n(85893),o=(n(92950),n(94581)),a=n(91831),i=n(13486),l=n(37182),c=n(34486),u=n(99772),s=function(){return s=Object.assign||function(e){for(var t,n=1,r=arguments.length;n<r;n++)for(var o in t=arguments[n])Object.prototype.hasOwnProperty.call(t,o)&&(e[o]=t[o]);return e},s.apply(this,arguments)},d=(0,a.Z)((function(e){return{root:{padding:0,background:"transparent",marginTop:e.spacing(3)},avatar:{"&:hover":{backgroundColor:function(e){var t=e.backgroundColor;return(0,o._j)(t,.1)}},backgroundColor:function(e){return e.backgroundColor},color:function(e){return e.color},boxShadow:e.shadows[2],width:e.spacing(8),height:e.spacing(8),fontSize:e.typography.h4.fontSize},icon:{fontSize:e.typography.h4.fontSize,width:e.spacing(8),height:e.spacing(8)},tooltip:{fontSize:12}}})),p=function(e){var t=e.id,n=e.nameLocale,o=e.Icon,a=e.backgroundColor,p=e.color,f=e.icon,v=e.notification,b=function(e,t){var n="function"==typeof Symbol&&e[Symbol.iterator];if(!n)return e;var r,o,a=n.call(e),i=[];try{for(;(void 0===t||t-- >0)&&!(r=a.next()).done;)i.push(r.value)}catch(e){o={error:e}}finally{try{r&&!r.done&&(n=a.return)&&n.call(a)}finally{if(o)throw o.error}}return i}((0,c.useTranslation)(),1)[0],h=d({backgroundColor:a||i.Z[50],color:p||i.Z[400]});return(0,r.jsx)(u.u,s({arrow:!0,title:b(n),placement:"top",classes:{tooltip:h.tooltip},TransitionComponent:l.Zoom},{children:(0,r.jsx)(l.Button,s({disableTouchRipple:!0,disableRipple:!0,disableFocusRipple:!0,className:h.root},{children:(0,r.jsx)(l.Badge,s({color:"error",badgeContent:null==v?void 0:v.badge,invisible:!v||v.badge<2},{children:o?(0,r.jsx)(o,{className:h.icon,fontSize:"large"},void 0):(0,r.jsx)(l.Avatar,s({className:h.avatar},{children:f||b(n)}),void 0)}),void 0)}),void 0)}),t)}},70790:function(e,t,n){"use strict";n.d(t,{d:function(){return u}});var r=n(85893),o=(n(92950),n(37182)),a=n(91831),i=n(34486),l=function(){return l=Object.assign||function(e){for(var t,n=1,r=arguments.length;n<r;n++)for(var o in t=arguments[n])Object.prototype.hasOwnProperty.call(t,o)&&(e[o]=t[o]);return e},l.apply(this,arguments)},c=(0,a.Z)((function(e){return{root:function(t){return{width:"100%",textAlign:"left",backgroundColor:t.backgroundColor||e.palette.background.default}},text:function(t){return{color:t.color||e.palette.text.primary}}}})),u=function(e){var t=e.app,n=t.backgroundColor,a=t.color,u=t.nameLocale,s=e.variant,d=void 0===s?"h5":s,p=function(e,t){var n={};for(var r in e)Object.prototype.hasOwnProperty.call(e,r)&&t.indexOf(r)<0&&(n[r]=e[r]);if(null!=e&&"function"==typeof Object.getOwnPropertySymbols){var o=0;for(r=Object.getOwnPropertySymbols(e);o<r.length;o++)t.indexOf(r[o])<0&&Object.prototype.propertyIsEnumerable.call(e,r[o])&&(n[r[o]]=e[r[o]])}return n}(e,["app","variant"]),f=c({color:a,backgroundColor:n}),v=function(e,t){var n="function"==typeof Symbol&&e[Symbol.iterator];if(!n)return e;var r,o,a=n.call(e),i=[];try{for(;(void 0===t||t-- >0)&&!(r=a.next()).done;)i.push(r.value)}catch(e){o={error:e}}finally{try{r&&!r.done&&(n=a.return)&&n.call(a)}finally{if(o)throw o.error}}return i}((0,i.useTranslation)(),1)[0];return(0,r.jsx)(o.Box,l({px:2,pt:2,className:f.root},p,{children:(0,r.jsx)(o.Typography,l({className:f.text,paragraph:!0,variant:d},{children:v(u)}),void 0)}),void 0)}},10187:function(e,t,n){"use strict";(0,n(81001).styled)("div")({background:"black",opacity:"0.6",position:"absolute",top:0,left:0,right:0,bottom:0,zIndex:5})},77293:function(e,t,n){"use strict";n.d(t,{z:function(){return i}});var r=n(85893),o=(n(92950),n(69397)),a=function(){return a=Object.assign||function(e){for(var t,n=1,r=arguments.length;n<r;n++)for(var o in t=arguments[n])Object.prototype.hasOwnProperty.call(t,o)&&(e[o]=t[o]);return e},a.apply(this,arguments)},i=function(e){var t=function(e,t){var n={};for(var r in e)Object.prototype.hasOwnProperty.call(e,r)&&t.indexOf(r)<0&&(n[r]=e[r]);if(null!=e&&"function"==typeof Object.getOwnPropertySymbols){var o=0;for(r=Object.getOwnPropertySymbols(e);o<r.length;o++)t.indexOf(r[o])<0&&Object.prototype.propertyIsEnumerable.call(e,r[o])&&(n[r[o]]=e[r[o]])}return n}(e,[]);return(0,r.jsx)(o.Z,a({"aria-label":"button"},t,{children:t.children}),void 0)}},45954:function(e,t,n){"use strict";n.d(t,{x:function(){return f}});var r=n(85893),o=(n(92950),n(37182)),a=n(91831),i=n(27611),l=n(57476),c=n(34486),u=function(){return u=Object.assign||function(e){for(var t,n=1,r=arguments.length;n<r;n++)for(var o in t=arguments[n])Object.prototype.hasOwnProperty.call(t,o)&&(e[o]=t[o]);return e},u.apply(this,arguments)},s=function(e,t){var n="function"==typeof Symbol&&e[Symbol.iterator];if(!n)return e;var r,o,a=n.call(e),i=[];try{for(;(void 0===t||t-- >0)&&!(r=a.next()).done;)i.push(r.value)}catch(e){o={error:e}}finally{try{r&&!r.done&&(n=a.return)&&n.call(a)}finally{if(o)throw o.error}}return i},d=function(e,t,n){if(n||2===arguments.length)for(var r,o=0,a=t.length;o<a;o++)!r&&o in t||(r||(r=Array.prototype.slice.call(t,0,o)),r[o]=t[o]);return e.concat(r||Array.prototype.slice.call(t))},p=(0,a.Z)((function(e){return{root:{borderTop:"1px solid",borderColor:e.palette.primary.main,width:"100%",minHeight:"10%",maxHeight:"100%",zIndex:2,overflow:"auto"}}})),f=function(e){var t=e.open,n=e.onClose,a=e.options,f=p(),v=s((0,c.useTranslation)(),1)[0],b=n?d(d([],s(a),!1),[{label:v("GENERIC.CLOSE"),onClick:n}],!1):a;return(0,r.jsx)(o.Slide,u({direction:"up",in:t,style:{position:"absolute",bottom:0},mountOnEnter:!0,unmountOnExit:!0},{children:(0,r.jsx)(o.Paper,u({square:!0,className:f.root},{children:(0,r.jsx)(i.a,u({disablePadding:!0},{children:b.map((function(e){return(0,r.jsxs)(l.H,u({selected:e.selected,button:!0,onClick:function(t){e.onClick(t,e),n()}},{children:[e.icon&&(0,r.jsx)(o.ListItemIcon,{children:e.icon},void 0),(0,r.jsx)(o.ListItemText,{primary:e.label,secondary:e.description},void 0)]}),e.key||e.label)}))}),void 0)}),void 0)}),void 0)}},27825:function(e,t,n){"use strict";n(85893),n(92950);var r=n(91831);n(37182),(0,r.Z)({root:{paddingLeft:"10px",zIndex:10,width:"90%",display:"flex",flexFlow:"column nowrap",position:"absolute",top:"80px"},displayBlock:{display:"flex",flexFlow:"column nowrap",justifyContent:"center",alignItems:"center",position:"relative"},displayNone:{display:"none"}})},2497:function(e,t,n){"use strict";n.d(t,{r:function(){return u}});var r=n(85893),o=n(92950),a=n(59789),i=n(37182),l=n(86235),c=function(){return c=Object.assign||function(e){for(var t,n=1,r=arguments.length;n<r;n++)for(var o in t=arguments[n])Object.prototype.hasOwnProperty.call(t,o)&&(e[o]=t[o]);return e},c.apply(this,arguments)},u=function(e){var t=e.items,n=e.Component,u=void 0===n?a.y:n,s=e.xs;return(0,r.jsx)(i.Grid,c({container:!0,alignItems:"center",direction:"row"},{children:t&&t.length&&t.map((function(e){return(0,r.jsx)(o.Fragment,{children:!e.isDisabled&&(0,r.jsx)(i.Grid,c({item:!0,xs:s},{children:(0,r.jsx)(i.Box,c({textAlign:"center"},{children:(0,r.jsx)(l.Link,c({to:e.path},{children:(0,r.jsx)(u,c({},e),void 0)}),void 0)}),void 0)}),e.id)},e.id)}))}),void 0)}},27611:function(e,t,n){"use strict";n.d(t,{a:function(){return i}});var r=n(85893),o=(n(92950),n(18843)),a=function(){return a=Object.assign||function(e){for(var t,n=1,r=arguments.length;n<r;n++)for(var o in t=arguments[n])Object.prototype.hasOwnProperty.call(t,o)&&(e[o]=t[o]);return e},a.apply(this,arguments)},i=function(e){var t=function(e,t){var n={};for(var r in e)Object.prototype.hasOwnProperty.call(e,r)&&t.indexOf(r)<0&&(n[r]=e[r]);if(null!=e&&"function"==typeof Object.getOwnPropertySymbols){var o=0;for(r=Object.getOwnPropertySymbols(e);o<r.length;o++)t.indexOf(r[o])<0&&Object.prototype.propertyIsEnumerable.call(e,r[o])&&(n[r[o]]=e[r[o]])}return n}(e,[]);return(0,r.jsx)(o.Z,a({"aria-label":"list"},t,{children:t.children}),void 0)}},57476:function(e,t,n){"use strict";n.d(t,{H:function(){return i}});var r=n(85893),o=(n(92950),n(29861)),a=function(){return a=Object.assign||function(e){for(var t,n=1,r=arguments.length;n<r;n++)for(var o in t=arguments[n])Object.prototype.hasOwnProperty.call(t,o)&&(e[o]=t[o]);return e},a.apply(this,arguments)},i=function(e){var t=function(e,t){var n={};for(var r in e)Object.prototype.hasOwnProperty.call(e,r)&&t.indexOf(r)<0&&(n[r]=e[r]);if(null!=e&&"function"==typeof Object.getOwnPropertySymbols){var o=0;for(r=Object.getOwnPropertySymbols(e);o<r.length;o++)t.indexOf(r[o])<0&&Object.prototype.propertyIsEnumerable.call(e,r[o])&&(n[r[o]]=e[r[o]])}return n}(e,[]);return(0,r.jsx)(o.ZP,a({"aria-label":"list item"},t,{children:t.children}),void 0)}},39519:function(e,t,n){"use strict";n.d(t,{T:function(){return i}});var r=n(85893),o=(n(92950),n(37182)),a=function(){return a=Object.assign||function(e){for(var t,n=1,r=arguments.length;n<r;n++)for(var o in t=arguments[n])Object.prototype.hasOwnProperty.call(t,o)&&(e[o]=t[o]);return e},a.apply(this,arguments)},i=function(e){var t,n=function(e,t){var n={};for(var r in e)Object.prototype.hasOwnProperty.call(e,r)&&t.indexOf(r)<0&&(n[r]=e[r]);if(null!=e&&"function"==typeof Object.getOwnPropertySymbols){var o=0;for(r=Object.getOwnPropertySymbols(e);o<r.length;o++)t.indexOf(r[o])<0&&Object.prototype.propertyIsEnumerable.call(e,r[o])&&(n[r[o]]=e[r[o]])}return n}(e,[]);return(0,r.jsx)(o.Box,a({display:"flex",justifyContent:"center",alignItems:"center",height:null!==(t=n.height)&&void 0!==t?t:"100%"},n,{children:(0,r.jsx)(o.CircularProgress,{},void 0)}),void 0)}},56289:function(e,t,n){"use strict";n.d(t,{u:function(){return u}});var r=n(85893),o=(n(92950),n(50594)),a=n(91831),i=n(37182),l=function(){return l=Object.assign||function(e){for(var t,n=1,r=arguments.length;n<r;n++)for(var o in t=arguments[n])Object.prototype.hasOwnProperty.call(t,o)&&(e[o]=t[o]);return e},l.apply(this,arguments)},c=(0,a.Z)({root:{padding:"24px",zIndex:10,marginTop:"15px",width:"90%",display:"flex",flexFlow:"column nowrap",position:"absolute",top:"80px"},displayBlock:{display:"flex",flexFlow:"column nowrap",alignItems:"center",margin:"auto"},displayNone:{display:"none"},imageModalCloseButton:{position:"absolute",right:0,top:0,width:"10%"}}),u=function(e){var t=e.children,n=e.visible,a=e.handleClose,u=c(),s=n?u.displayBlock:u.displayNone;return(0,r.jsx)("div",l({className:s},{children:(0,r.jsxs)(i.Paper,l({className:u.root},{children:[(0,r.jsx)(i.Button,l({onClick:a,className:u.imageModalCloseButton},{children:(0,r.jsx)(o.Z,{},void 0)}),void 0),t]}),void 0)}),void 0)};t.Z=u},77942:function(e,t,n){"use strict";n.d(t,{t:function(){return s}});var r=n(85893),o=n(92950),a=n(37182),i=n(45705),l=n(91518),c=n(56289),u=function(){return u=Object.assign||function(e){for(var t,n=1,r=arguments.length;n<r;n++)for(var o in t=arguments[n])Object.prototype.hasOwnProperty.call(t,o)&&(e[o]=t[o]);return e},u.apply(this,arguments)},s=function(e){var t=e.src,n=e.alt,s=e.size,d=function(e,t){var n="function"==typeof Symbol&&e[Symbol.iterator];if(!n)return e;var r,o,a=n.call(e),i=[];try{for(;(void 0===t||t-- >0)&&!(r=a.next()).done;)i.push(r.value)}catch(e){o={error:e}}finally{try{r&&!r.done&&(n=a.return)&&n.call(a)}finally{if(o)throw o.error}}return i}((0,o.useState)(!1),2),p=d[0],f=d[1];return(0,r.jsxs)(r.Fragment,{children:[(0,r.jsx)(a.Button,u({onClick:function(){return f(!0)}},{children:(0,r.jsx)(i.T,{size:s,src:t,alt:n},void 0)}),void 0),(0,r.jsx)(c.Z,u({visible:p,handleClose:function(){return f(!1)}},{children:(0,r.jsx)(l.B,{src:t,alt:n},void 0)}),void 0)]},void 0)}},91518:function(e,t,n){"use strict";n.d(t,{B:function(){return a}});var r=n(85893),o=(n(92950),(0,n(91831).Z)({root:{width:"100%",objectFit:"contain"},rootPopper:{width:"100%",objectFit:"contain",transform:"scale(1.2)"}})),a=function(e){var t=e.src,n=e.alt,a=e.popper,i=void 0!==a&&a;return(0,r.jsx)("img",{className:i?o().rootPopper:o().root,src:t,alt:n},void 0)}},93982:function(e,t,n){"use strict";n.d(t,{Q:function(){return p}});var r=n(85893),o=n(92950),a=n(37182),i=n(91831),l=n(77094),c=n(34486),u=function(){return u=Object.assign||function(e){for(var t,n=1,r=arguments.length;n<r;n++)for(var o in t=arguments[n])Object.prototype.hasOwnProperty.call(t,o)&&(e[o]=t[o]);return e},u.apply(this,arguments)},s=function(e,t){var n="function"==typeof Symbol&&e[Symbol.iterator];if(!n)return e;var r,o,a=n.call(e),i=[];try{for(;(void 0===t||t-- >0)&&!(r=a.next()).done;)i.push(r.value)}catch(e){o={error:e}}finally{try{r&&!r.done&&(n=a.return)&&n.call(a)}finally{if(o)throw o.error}}return i},d=(0,i.Z)((function(e){return{cover:{cursor:"pointer",backgroundColor:e.palette.background.default,color:e.palette.getContrastText(e.palette.background.default),visibility:function(e){return e.covered?"visible":"hidden"}}}})),p=function(e){var t=e.children,n=s((0,l.rV)(),1)[0],i=s((0,o.useState)(!1),2),p=i[0],f=i[1],v=s((0,o.useState)(!1),2),b=v[0],h=v[1],y=s((0,c.useTranslation)(),1)[0],g=d({covered:p});return(0,o.useEffect)((function(){!0===n.streamerMode&&f(!0),h(!0)}),[n.streamerMode]),(0,r.jsxs)(a.Box,u({width:"100%",position:"relative"},{children:[(0,r.jsx)(a.Box,u({onClick:function(){return f(!1)},className:g.cover,width:"100%",height:"100%",position:"absolute",display:"flex",alignItems:"center",justifyContent:"center",top:0,left:0},{children:y("GENERIC_CLICK_TO_REVEAL")}),void 0),(0,r.jsx)(a.Box,u({width:"100%",height:"100%",visibility:b?"visible":"hidden"},{children:t}),void 0)]}),void 0)}},45705:function(e,t,n){"use strict";n.d(t,{T:function(){return a}});var r=n(85893),o=(n(92950),(0,n(91831).Z)({root:function(e){return{objectFit:"contain",width:e.size}}})),a=function(e){var t=e.src,n=e.alt,a=e.size,i=void 0===a?"3em":a;return(0,r.jsx)("img",{className:o({size:i}).root,src:t,alt:n},void 0)}},96269:function(e,t,n){"use strict";n.d(t,{U:function(){return v}});var r=n(85893),o=(n(92950),n(37182)),a=n(58524),i=n(42761),l=n(11163),c=function(){return c=Object.assign||function(e){for(var t,n=1,r=arguments.length;n<r;n++)for(var o in t=arguments[n])Object.prototype.hasOwnProperty.call(t,o)&&(e[o]=t[o]);return e},c.apply(this,arguments)},u=(0,a.ZP)("div")((function(e){var t=e.theme;return{position:"relative",borderRadius:t.shape.borderRadius,backgroundColor:(0,o.emphasize)(t.palette.background.paper,.21),"&:hover":{backgroundColor:(0,o.emphasize)(t.palette.background.paper,.28)},marginLeft:t.spacing(1),width:"auto"}})),s=(0,a.ZP)("div")((function(e){return{padding:e.theme.spacing(0,.7),height:"100%",position:"absolute",pointerEvents:"none",display:"flex",alignItems:"center",justifyContent:"center"}})),d=(0,a.ZP)(l.MA)((function(e){var t=e.theme;return{fontWeight:400,fontSize:18,border:"1px solid",borderColor:t.palette.divider,"& .MuiInputBase-input":{padding:t.spacing(1,4,1,4),transition:t.transitions.create(["width","border"]),width:"16ch","&:focus":{width:"24ch",borderLeft:"2px solid ".concat(t.palette.primary.main," ")}}}})),p=(0,a.ZP)(o.Paper)((function(e){return e.theme,{display:"flex",height:"60px",justifyContent:"center",alignItems:"center"}})),f={onChange:function(){},value:"",placeholder:"Search..."},v=function(e){var t=void 0===e?f:e,n=t.value,o=t.onChange,a=t.placeholder;return(0,r.jsx)(p,c({variant:"outlined"},{children:(0,r.jsxs)(u,{children:[(0,r.jsx)(s,{children:(0,r.jsx)(i.Z,{},void 0)},void 0),(0,r.jsx)(d,{value:n,onChange:o,placeholder:a,inputProps:{"aria-label":"search"}},void 0)]},void 0)}),void 0)}},45071:function(e,t,n){"use strict";n.d(t,{Y:function(){return c}});var r=n(85893),o=n(37182),a=n(91831),i=(n(92950),function(){return i=Object.assign||function(e){for(var t,n=1,r=arguments.length;n<r;n++)for(var o in t=arguments[n])Object.prototype.hasOwnProperty.call(t,o)&&(e[o]=t[o]);return e},i.apply(this,arguments)}),l=(0,a.Z)((function(e){return{root:{color:function(t){var n=t.color;return e.palette[n].main},"&:hover":{backgroundColor:function(t){var n=t.color;return(0,o.alpha)(e.palette[n].light,e.palette.action.hoverOpacity)}}},outlined:{border:function(t){var n=t.color;return"1px solid ".concat((0,o.alpha)(e.palette[n].main,.5))},"&:hover":{border:function(t){var n=t.color;return"1px solid ".concat(e.palette[n].main)}}},contained:{color:function(t){var n=t.color;return e.palette[n].contrastText},backgroundColor:function(t){var n=t.color;return e.palette[n].main},"&:hover":{backgroundColor:function(t){var n=t.color;return e.palette[n].dark}}}}}),{name:"MuiButton"}),c=function(e){var t=e.color,n=void 0===t?"info":t,a=e.variant,c=e.className,u=function(e,t){var n={};for(var r in e)Object.prototype.hasOwnProperty.call(e,r)&&t.indexOf(r)<0&&(n[r]=e[r]);if(null!=e&&"function"==typeof Object.getOwnPropertySymbols){var o=0;for(r=Object.getOwnPropertySymbols(e);o<r.length;o++)t.indexOf(r[o])<0&&Object.prototype.propertyIsEnumerable.call(e,r[o])&&(n[r[o]]=e[r[o]])}return n}(e,["color","variant","className"]),s=l({color:n});return(0,r.jsx)(o.Button,i({variant:a,className:"".concat(s.root," ").concat(s[a]||""," ").concat(c)},u),void 0)}},23726:function(e,t,n){"use strict";n.d(t,{w:function(){return c}});var r=n(85893),o=n(37182),a=n(91831),i=(n(92950),function(){return i=Object.assign||function(e){for(var t,n=1,r=arguments.length;n<r;n++)for(var o in t=arguments[n])Object.prototype.hasOwnProperty.call(t,o)&&(e[o]=t[o]);return e},i.apply(this,arguments)}),l=(0,a.Z)((function(e){return{root:{color:function(t){var n=t.color;return e.palette[n].contrastText},backgroundColor:function(t){var n=t.color;return e.palette[n].main},"&:hover":{backgroundColor:function(t){var n=t.color;return e.palette[n].light}}},outlined:{border:function(t){var n=t.color;return"1px solid ".concat((0,o.alpha)(e.palette[n].main,.5))},"&:hover":{border:function(t){var n=t.color;return"1px solid ".concat(e.palette[n].main)}},"&$disabled":{border:"1px solid ".concat(e.palette.action.disabled)}},contained:{color:function(t){var n=t.color;return e.palette[n].contrastText},backgroundColor:function(t){var n=t.color;return e.palette[n].main},"&:hover":{backgroundColor:function(t){var n=t.color;return e.palette[n].dark}}}}}),{name:"MuiIconButton"}),c=function(e){var t=e.color,n=void 0===t?"info":t,a=e.size,c=e.className,u=function(e,t){var n={};for(var r in e)Object.prototype.hasOwnProperty.call(e,r)&&t.indexOf(r)<0&&(n[r]=e[r]);if(null!=e&&"function"==typeof Object.getOwnPropertySymbols){var o=0;for(r=Object.getOwnPropertySymbols(e);o<r.length;o++)t.indexOf(r[o])<0&&Object.prototype.propertyIsEnumerable.call(e,r[o])&&(n[r[o]]=e[r[o]])}return n}(e,["color","size","className"]),s=l({color:n});return(0,r.jsx)(o.IconButton,i({className:"".concat(s.root," ").concat(c),size:a},u),void 0)}},99772:function(e,t,n){"use strict";n.d(t,{u:function(){return i}});var r=n(85893),o=(n(92950),n(37182)),a=function(){return a=Object.assign||function(e){for(var t,n=1,r=arguments.length;n<r;n++)for(var o in t=arguments[n])Object.prototype.hasOwnProperty.call(t,o)&&(e[o]=t[o]);return e},a.apply(this,arguments)},i=function(e){var t=e.children,n=function(e,t){var n={};for(var r in e)Object.prototype.hasOwnProperty.call(e,r)&&t.indexOf(r)<0&&(n[r]=e[r]);if(null!=e&&"function"==typeof Object.getOwnPropertySymbols){var o=0;for(r=Object.getOwnPropertySymbols(e);o<r.length;o++)t.indexOf(r[o])<0&&Object.prototype.propertyIsEnumerable.call(e,r[o])&&(n[r[o]]=e[r[o]])}return n}(e,["children"]);return(0,r.jsx)(o.Tooltip,a({},n,{children:t}),void 0)}},24833:function(e,t,n){"use strict";n.d(t,{i:function(){return u}});var r=n(85893),o=(n(92950),n(91831)),a=n(37182),i=n(62665),l=function(){return l=Object.assign||function(e){for(var t,n=1,r=arguments.length;n<r;n++)for(var o in t=arguments[n])Object.prototype.hasOwnProperty.call(t,o)&&(e[o]=t[o]);return e},l.apply(this,arguments)},c=(0,o.Z)({root:{position:"absolute",bottom:"15px",right:"15px"}}),u=function(e){var t=e.handleClick,n=c();return(0,r.jsx)("div",l({className:n.root},{children:(0,r.jsx)(a.Fab,l({color:"primary",onClick:t},{children:(0,r.jsx)(i.Z,{},void 0)}),void 0)}),void 0)}},24219:function(e,t,n){"use strict";n.r(t),n.d(t,{Alert:function(){return r.b},AppContent:function(){return o.L},AppIcon:function(){return a.y},AppTitle:function(){return i.d},AppWrapper:function(){return l.O},Button:function(){return c.z},ContextMenu:function(){return u.x},GridMenu:function(){return s.r},InputBase:function(){return d.MA},List:function(){return p.a},ListItem:function(){return w.H},LoadingSpinner:function(){return f.T},Modal:function(){return v.u},Picture:function(){return b.t},PictureResponsive:function(){return h.B},PictureReveal:function(){return y.Q},PictureThumbnail:function(){return g.T},ProfileUpdateButton:function(){return j.i},SearchField:function(){return m.U},StatusButton:function(){return x.Y},StatusIconButton:function(){return O.w},TextField:function(){return d.nv},Tooltip:function(){return S.u},toggleKeys:function(){return d.di}});var r=n(76587),o=n(61103),a=n(59789),i=n(70790),l=n(10684),c=(n(10187),n(77293)),u=n(45954),s=(n(27825),n(2497)),d=n(11163),p=n(27611),f=n(39519),v=n(56289),b=n(77942),h=n(91518),y=n(93982),g=n(45705),m=n(96269),x=n(45071),O=n(23726),S=n(99772),j=n(24833),w=n(57476)},98891:function(e,t,n){"use strict";n.d(t,{Id:function(){return r},Yj:function(){return o}});var r=function(){return!1},o=function(){var e;return window.GetParentResourceName?null===(e=window)||void 0===e?void 0:e.GetParentResourceName():"npwd"}},84782:function(e){"use strict";e.exports=JSON.parse('{"cellProvider":"iFruit","defaultLanguage":"en","wallpapers":[{"label":"Minimal","value":"minimal.jpg"},{"label":"Surf","value":"surf.jpg"},{"label":"Waves","value":"waves.jpg"},{"label":"Paradox","value":"paradox.png"},{"label":"NPWD 2020","value":"npwd2020.png"},{"label":"Default","value":"default.jpg"}],"frames":[{"label":"Default","value":"default.png"},{"label":"Blue","value":"blue.png"},{"label":"Gold","value":"gold.png"},{"label":"Kawaii","value":"kawaii.png"},{"label":"Minimal","value":"minimal.png"},{"label":"Pink","value":"pink.png"},{"label":"White","value":"white.png"}],"zoomOptions":[{"label":"150%","value":1.5},{"label":"100%","value":1},{"label":"90%","value":0.9},{"label":"80%","value":0.8},{"label":"70%","value":0.7}],"languages":[{"label":"English","value":"en"},{"label":"Español","value":"es"},{"label":"Français","value":"fr"},{"label":"Norsk","value":"no"},{"label":"Polski","value":"pl"},{"label":"Bosanski","value":"ba"},{"label":"Português","value":"pt"},{"label":"Hungarian","value":"hu"},{"label":"Čeština","value":"cs"},{"label":"Nederlands","value":"nl"},{"label":"Deutsch","value":"de"},{"label":"Finnish","value":"fi"},{"label":"Italian","value":"it"},{"label":"Indonesia","value":"id"},{"label":"繁體中文","value":"zhtw"},{"label":"Русский","value":"ru"},{"label":"Svenska","value":"sv"},{"label":"Türkçe","value":"tr"},{"label":"Lietuvių","value":"lt"}],"ringtones":[{"label":"iFruit","value":"PHONE_GENERIC_RING_01"},{"label":"Desk Phone","value":"PHONE_GENERIC_RING_02"},{"label":"Rotary Phone","value":"PHONE_GENERIC_RING_03"}],"notiSounds":[{"label":"Online","value":"Phone_SoundSet_Default"},{"label":"Michael","value":"Phone_SoundSet_Michael"},{"label":"Trevor","value":"Phone_SoundSet_Trevor"},{"label":"Franklin","value":"Phone_SoundSet_Franklin"}],"notiFilters":[{"label":"All Tweets","value":"all"},{"label":"Only Mentions","value":"mentions"}],"defaultSettings":{"language":{"label":"English","value":"en"},"callVolume":50,"iconSet":{"label":"Material","value":{"custom":false,"name":"material"}},"wallpaper":{"label":"Paradox","value":"paradox.png"},"customWallpaper":"","frame":{"label":"Default","value":"default.png"},"theme":{"label":"Dark","value":"taso-dark"},"zoom":{"label":"90%","value":0.9},"streamerMode":false,"ringtone":{"label":"iFruit","value":"PHONE_GENERIC_RING_01"},"notiSound":{"label":"Online","value":"Phone_SoundSet_Default"},"TWITTER_notiFilter":{"label":"All Tweets","value":"all"},"TWITTER_notiSound":{"label":"Online","value":"online"},"TWITTER_notiSoundVol":25,"TWITTER_notifyNewFeedTweet":true,"MARKETPLACE_notifyNewListing":true},"appSettings":{"browserHomePage":"https://docs.projecterror.dev"},"iconSet":[{"label":"Material","value":{"custom":false,"name":"material"}}],"themes":[{"label":"Dark","value":"taso-dark"},{"label":"Light","value":"default-light"}],"debug":{"printDebugLogs":true,"logLevel":1,"shouldShowAtomDebug":false},"SentryErrorMetrics":true}')}}]);