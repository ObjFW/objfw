include ../extra.mk

SUBDIRS = ${RUNTIME} exceptions encodings forwarding
SUBDIRS_AFTER = ${BRIDGE}
DISTCLEAN = Info.plist objfw-defs.h

SHARED_LIB = ${OBJFW_SHARED_LIB}
STATIC_LIB = ${OBJFW_STATIC_LIB}
FRAMEWORK = ${OBJFW_FRAMEWORK}
LIB_MAJOR = ${OBJFW_LIB_MAJOR}
LIB_MINOR = ${OBJFW_LIB_MINOR}

SRCS = OFASPrintF.m			\
       OFApplication.m			\
       OFArray.m			\
       OFBase64.m			\
       OFBlock.m			\
       OFCRC16.m			\
       OFCRC32.m			\
       OFCharacterSet.m			\
       OFColor.m			\
       OFConstantString.m		\
       OFCountedSet.m			\
       OFData.m				\
       OFData+CryptographicHashing.m	\
       OFData+MessagePackParsing.m	\
       OFDate.m				\
       OFDictionary.m			\
       OFEnumerator.m			\
       OFFileManager.m			\
       OFGZIPStream.m			\
       OFHMAC.m				\
       OFHuffmanTree.m			\
       OFInflate64Stream.m		\
       OFInflateStream.m		\
       OFInvocation.m			\
       OFLHAArchive.m			\
       OFLHAArchiveEntry.m		\
       OFList.m				\
       OFLocale.m			\
       OFMD5Hash.m			\
       OFMapTable.m			\
       OFMessagePackExtension.m		\
       OFMethodSignature.m		\
       OFMutableArray.m			\
       OFMutableData.m			\
       OFMutableDictionary.m		\
       OFMutableLHAArchiveEntry.m	\
       OFMutablePair.m			\
       OFMutableSet.m			\
       OFMutableString.m		\
       OFMutableTarArchiveEntry.m	\
       OFMutableTriple.m		\
       OFMutableURL.m			\
       OFMutableZIPArchiveEntry.m	\
       OFNull.m				\
       OFNumber.m			\
       OFObject.m			\
       OFObject+KeyValueCoding.m	\
       OFObject+Serialization.m		\
       OFOnce.m				\
       OFOptionsParser.m		\
       OFPBKDF2.m			\
       OFPair.m				\
       OFRIPEMD160Hash.m		\
       OFRunLoop.m			\
       OFSHA1Hash.m			\
       OFSHA224Hash.m			\
       OFSHA224Or256Hash.m		\
       OFSHA256Hash.m			\
       OFSHA384Hash.m			\
       OFSHA384Or512Hash.m		\
       OFSHA512Hash.m			\
       OFScrypt.m			\
       OFSecureData.m			\
       OFSeekableStream.m		\
       OFSerialization.m		\
       OFSet.m				\
       OFSortedList.m			\
       OFStdIOStream.m			\
       OFStrPTime.m			\
       OFStream.m			\
       OFString.m			\
       OFString+CryptographicHashing.m	\
       OFString+JSONParsing.m		\
       OFString+PropertyListParsing.m	\
       OFString+Serialization.m		\
       OFString+URLEncoding.m		\
       OFString+XMLEscaping.m		\
       OFString+XMLUnescaping.m		\
       ${OF_SUBUPROCESS_M}		\
       OFSystemInfo.m			\
       OFTarArchive.m			\
       OFTarArchiveEntry.m		\
       OFThread.m			\
       OFTimer.m			\
       OFTriple.m			\
       OFURL.m				\
       OFURLHandler.m			\
       OFValue.m			\
       OFXMLAttribute.m			\
       OFXMLCDATA.m			\
       OFXMLCharacters.m		\
       OFXMLComment.m			\
       OFXMLElement.m			\
       OFXMLElement+Serialization.m	\
       OFXMLElementBuilder.m		\
       OFXMLNode.m			\
       OFXMLParser.m			\
       OFXMLProcessingInstruction.m	\
       OFZIPArchive.m			\
       OFZIPArchiveEntry.m		\
       ${USE_SRCS_FILES}		\
       ${USE_SRCS_PLUGINS}		\
       ${USE_SRCS_SOCKETS}		\
       ${USE_SRCS_THREADS}		\
       ${USE_SRCS_WINDOWS}
SRCS_FILES = OFFile.m			\
	     OFINICategory.m		\
	     OFINIFile.m		\
	     OFSettings.m		\
	     OFString+PathAdditions.m
SRCS_IPX = OFIPXSocket.m	\
	   OFSPXSocket.m	\
	   OFSPXStreamSocket.m
SRCS_PLUGINS = OFPlugin.m
SRCS_SOCKETS = OFDNSQuery.m			\
	       OFDNSResolver.m			\
	       OFDNSResourceRecord.m		\
	       OFDNSResponse.m			\
	       OFDatagramSocket.m		\
	       OFHTTPClient.m			\
	       OFHTTPCookie.m			\
	       OFHTTPCookieManager.m		\
	       OFHTTPRequest.m			\
	       OFHTTPResponse.m			\
	       OFHTTPServer.m			\
	       OFSequencedPacketSocket.m	\
	       OFSocket.m			\
	       OFStreamSocket.m			\
	       OFTCPSocket.m			\
	       OFUDPSocket.m			\
	       ${USE_SRCS_IPX}
SRCS_THREADS = OFCondition.m		\
	       OFMutex.m		\
	       OFPlainCondition.m	\
	       OFPlainMutex.m		\
	       OFPlainThread.m		\
	       OFRecursiveMutex.m	\
	       OFTLSKey.m		\
	       OFThreadPool.m
SRCS_WINDOWS = OFWin32ConsoleStdIOStream.m	\
	       OFWindowsRegistryKey.m

INCLUDES_ATOMIC = OFAtomic.h			\
		  platform/GCC4/OFAtomic.h	\
		  platform/GCC4.7/OFAtomic.h	\
		  platform/PowerPC/OFAtomic.h	\
		  platform/macOS/OFAtomic.h	\
		  platform/x86/OFAtomic.h
INCLUDES := ${SRCS:.m=.h}			\
	    OFCollection.h			\
	    OFCryptographicHash.h		\
	    OFJSONRepresentation.h		\
	    OFKernelEventObserver.h		\
	    OFKeyValueCoding.h			\
	    OFLocking.h				\
	    OFMessagePackRepresentation.h	\
	    OFTLSSocket.h			\
	    ObjFW.h				\
	    macros.h				\
	    objfw-defs.h			\
	    platform.h				\
	    ${USE_INCLUDES_ATOMIC}

SRCS += OFAdjacentArray.m		\
	OFAdjacentSubarray.m		\
	OFBitSetCharacterSet.m		\
	OFBytesValue.m			\
	OFCountedMapTableSet.m		\
	OFInvertedCharacterSet.m	\
	OFLHADecompressingStream.m	\
	OFMapTableDictionary.m		\
	OFMapTableSet.m			\
	OFMutableAdjacentArray.m	\
	OFMutableMapTableDictionary.m	\
	OFMutableMapTableSet.m		\
	OFMutableUTF8String.m		\
	OFNonretainedObjectValue.m	\
	OFPointValue.m			\
	OFPointerValue.m		\
	OFRangeCharacterSet.m		\
	OFRangeValue.m			\
	OFRectValue.m			\
	OFSandbox.m			\
	OFSizeValue.m			\
	OFSubarray.m			\
	OFUTF8String.m			\
	${LIBBASES_M}			\
	${RUNTIME_AUTORELEASE_M}	\
	${RUNTIME_INSTANCE_M}		\
       ${UNICODE_M}
SRCS_FILES += OFFileURLHandler.m	\
	      OFINIFileSettings.m
SRCS_SOCKETS += OFDNSResolverSettings.m			\
		OFHTTPURLHandler.m			\
		OFHostAddressResolver.m			\
		OFIPSocketAsyncConnector.m		\
		OFKernelEventObserver.m			\
		${OF_EPOLL_KERNEL_EVENT_OBSERVER_M}	\
		${OF_KQUEUE_KERNEL_EVENT_OBSERVER_M}	\
		${OF_POLL_KERNEL_EVENT_OBSERVER_M}	\
		${OF_SELECT_KERNEL_EVENT_OBSERVER_M}	\
		OFTCPSocketSOCKS5Connector.m

OBJS_EXTRA = exceptions/exceptions.a	\
	     encodings/encodings.a	\
	     forwarding/forwarding.a
LIB_OBJS_EXTRA = exceptions/exceptions.lib.a	\
		 encodings/encodings.lib.a	\
		 forwarding/forwarding.lib.a

include ../buildsys.mk

CPPFLAGS += -I. -I.. -Iexceptions -Iruntime
LD = ${OBJC}
FRAMEWORK_LIBS := -Fruntime				\
		  ${RUNTIME_FRAMEWORK_LIBS}		\
		  ${REEXPORT_RUNTIME_FRAMEWORK}		\
		  ${LIBS}
LIBS := -Lruntime ${RUNTIME_LIBS} ${REEXPORT_RUNTIME} ${LIBS}
